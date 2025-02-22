//
//  ConfirmationDailyConsumptionVC.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 14/05/23.
//

import UIKit
import Components
import Common
import Core
import WaterManagementDomain
import Combine

class ConfirmationDailyConsumptionVC: BaseChildPageController {
    var cancellableBag = Set<AnyCancellable>()

	private lazy var dailyWaterEditText = {
		let text = InputFieldWithSuffix()
		return text
	}()

	private lazy var volumeFormatSegmentationControl = {
		let button =  UISegmentedControl(items: SystemFormat.allCases.map { $0.localizedDisplay })
		button.selectedSegmentIndex = 0
        button.backgroundColor = AppColorGroup.surface.color
		let attributes = [
            NSAttributedString.Key.foregroundColor: AppColorGroup.surface.onColor,
			NSAttributedString.Key.font: UIFont.body
		]
        let attributesSelected = [
            NSAttributedString.Key.foregroundColor: AppColorGroup.primary.onColor,
            NSAttributedString.Key.font: UIFont.body
        ]
		button.setTitleTextAttributes(attributes, for: .normal)
		button.setTitleTextAttributes(attributesSelected, for: .selected)
        button.selectedSegmentTintColor = AppColorGroup.primary.color
        button.addTarget(self, action: #selector(volumeFormatSegmentationControlChanged), for: .valueChanged)
		return button
	}()

	private lazy var confirmationBtn = {
		let button = UIButton()
		button.setTitle(String(localized: "generic.confirm"), for: .normal)
        button.setTitleColor(AppColorGroup.background.onColor, for: .normal)
        button.titleLabel?.font = .buttonBig
        button.addTapListener { [weak self] in
            self?.onConfirmPressed()
        }
		return button
	}()

    private lazy var timePeriodSelector = {
        let picker = TimePeriodPickerView()
        picker.updateData(dayTime: firstAccessInformationViewModel.timePeriodFifteenMinutesSpaced)
        picker.selectRow(firstAccessInformationViewModel.initialTimeIndex, inComponent: 0, animated: false)
        picker.selectRow(firstAccessInformationViewModel.finalTimeIndex, inComponent: 1, animated: false)
        picker.valueChangeListener = { [weak self] in
            self?.firstAccessInformationViewModel.setInitialTimeIndex($0.initialTimeIndex)
            self?.firstAccessInformationViewModel.setFinalTimeIndex($0.finalTimeIndex)
        }
        return picker
    }()

    private lazy var shouldRemindSwitch = {
        let uiSwitch = SwitchWithLabel()
        uiSwitch.label.text = String(localized: "welcomeConfirmation.remindMe")
        uiSwitch.label.font = UIFont.h4
        uiSwitch.switchView.setOn(true, animated: false)
        uiSwitch.switchView.addTarget(self, action: #selector(onShouldRemindSwitchChanged), for: .valueChanged)
        return uiSwitch
    }()

	let viewWrapper = UIView()

    static func newInstance(firstAccessInformationViewModel: FirstAccessInformationSharedViewModel) -> ConfirmationDailyConsumptionVC {
        ConfirmationDailyConsumptionVC(firstAccessInformationViewModel: firstAccessInformationViewModel)
    }

	override func viewWillAppear(_ animated: Bool) {
		firstAccessInformationViewModel.expectedWaterVolume
            .eraseToAnyPublisher()
            .first()
            .sinkUI {expectedWaterVolume in
                switch expectedWaterVolume {
                case .successful(let waterQuantity):
                    self.dailyWaterEditText.text = waterQuantity.toString()
                default:
                    return
                }
            }.store(in: &cancellableBag)

	}

	override func viewDidLoad() {
		super.viewDidLoad()
		prepareHideKeyboardWhenTappedOut()
		prepareConfiguration()
		prepareConstraints()
        observeViewModel()
	}

    func observeViewModel() {
        firstAccessInformationViewModel.$shouldRemind.sinkUI { [weak self] bool in
            self?.timePeriodSelector.isHidden = !bool
        }.store(in: &cancellableBag)

        firstAccessInformationViewModel.scheduleNotificationOnConfirmEvent.sinkUI { _ in
            self.requestNotificationPermissionThenSchedule()
        }.store(in: &cancellableBag)

        firstAccessInformationViewModel.$currentVolume.sinkUI { [weak self] volume in
            guard let self else { return }
            dailyWaterEditText.suffix.text = volume.unit.system.formatDisplay
            dailyWaterEditText.text = volume.formattedValue
        }.store(in: &cancellableBag)
    }

	func prepareConfiguration() {
		informativeMainText.text = String(localized: "welcomeConfirmation.mainText")
	}

	func prepareConstraints() {
		view.addConstrainedSubviews(
			viewWrapper,
			dailyWaterEditText,
			confirmationBtn,
            timePeriodSelector,
			shouldRemindSwitch,
			volumeFormatSegmentationControl
		)

		NSLayoutConstraint.activate([
			viewWrapper.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			viewWrapper.bottomAnchor.constraint(equalTo: dailyWaterEditText.topAnchor),
			viewWrapper.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			viewWrapper.widthAnchor.constraint(equalTo: view.widthAnchor),

			informativeMainText.centerYAnchor.constraint(equalTo: viewWrapper.centerYAnchor),
			informativeMainText.centerXAnchor.constraint(equalTo: viewWrapper.centerXAnchor),
			informativeMainText.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32),

			dailyWaterEditText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			dailyWaterEditText.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			dailyWaterEditText.widthAnchor.constraint(equalToConstant: 180),
			dailyWaterEditText.heightAnchor.constraint(equalToConstant: 60),

            timePeriodSelector.bottomAnchor.constraint(equalTo: shouldRemindSwitch.topAnchor, constant: -16),
            timePeriodSelector.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timePeriodSelector.widthAnchor.constraint(equalToConstant: 300),
            timePeriodSelector.heightAnchor.constraint(equalToConstant: 150),

			shouldRemindSwitch.bottomAnchor.constraint(equalTo: confirmationBtn.topAnchor, constant: -32),
			shouldRemindSwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			shouldRemindSwitch.widthAnchor.constraint(equalToConstant: 300),

			confirmationBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
			confirmationBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),

			volumeFormatSegmentationControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			volumeFormatSegmentationControl.topAnchor.constraint(equalTo: dailyWaterEditText.bottomAnchor, constant: 8)
		])
	}

	func onConfirmPressed() {
        firstAccessInformationViewModel.setCurrentVolume(Double(dailyWaterEditText.text ?? "") ?? 0)
        let notificationCenter = UNUserNotificationCenter.current()

        notificationCenter.getNotificationSettings { settings in
            Task { @MainActor in
                switch settings.authorizationStatus {
                case .notDetermined:
                    try await notificationCenter.requestAuthorization(options: [.alert, .badge, .sound])
                    self.firstAccessInformationViewModel.confirm()
                case .authorized, .provisional, .denied:
                    self.firstAccessInformationViewModel.confirm()

                default:
                    print("Unknown authorization status")
                }
            }
        }
	}

	func requestNotificationPermissionThenSchedule() {
		UNUserNotificationCenter.current().requestAuthorization(
			options: [.alert, .badge, .sound]
		) { _, _ in
			self.firstAccessInformationViewModel.scheduleReminderNotifications()
		}
	}

    @objc private func volumeFormatSegmentationControlChanged() {
        let index = volumeFormatSegmentationControl.selectedSegmentIndex
        let format = (SystemFormat(rawValue: index) ?? SystemFormat.metric)
        firstAccessInformationViewModel.setCurrentVolume(Double(dailyWaterEditText.text ?? "") ?? 0)
        firstAccessInformationViewModel.setCurrentVolumeFormat(format)
    }

    @objc private func onShouldRemindSwitchChanged() {
        firstAccessInformationViewModel.setShouldRemind(shouldRemindSwitch.switchView.isOn)
    }

}
