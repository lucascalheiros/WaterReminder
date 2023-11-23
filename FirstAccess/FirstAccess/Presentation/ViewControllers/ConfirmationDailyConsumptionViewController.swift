//
//  ConfirmationDailyConsumptionVC.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 14/05/23.
//

import UIKit
import RxSwift
import RxCocoa
import Components
import Common
import Core
import WaterManagementDomain

class ConfirmationDailyConsumptionVC: BaseChildPageController {
	private let disposeBag = DisposeBag()

	private lazy var dailyWaterEditText = {
		let text = InputFieldWithSuffix()
		return text
	}()

	private var currentVolumeFormat = VolumeFormat.metric

	private lazy var volumeFormatSegmentationControl = {
		let button =  UISegmentedControl(items: VolumeFormat.allCases.map { $0.localizedDisplay })
		dailyWaterEditText.suffix.text = VolumeFormat.metric.formatDisplay
		button.selectedSegmentIndex = 0
        button.backgroundColor = AppColorGroup.surface.color
		let attributes = [
			NSAttributedString.Key.foregroundColor: UIColor.white,
			NSAttributedString.Key.font: UIFont.body
		]
		button.setTitleTextAttributes(attributes, for: .normal)
		button.setTitleTextAttributes(attributes, for: .selected)
        button.selectedSegmentTintColor = AppColorGroup.primary.color
		button.rx.selectedSegmentIndex.bind {
			let format = (VolumeFormat(rawValue: $0) ?? VolumeFormat.metric)
			self.dailyWaterEditText.suffix.text = format.formatDisplay
			self.dailyWaterEditText.text = String(format: "%.1f", self.waterVolumeTo(format))
			self.currentVolumeFormat = format
		}.disposed(by: disposeBag)
		return button
	}()

	private lazy var confirmationBtn = {
		let button = UIButton()
		button.setTitle(String(localized: "generic.confirm"), for: .normal)
        button.titleLabel?.font = .buttonBig
		button.rx.tap.bind {
			self.onConfirmPressed()
		}.disposed(by: disposeBag)
		return button
	}()

    private lazy var timePeriodSelector = {
        let picker = TimePeriodPickerView()
        picker.updateData(dayTime: firstAccessInformationViewModel.timePeriodFifteenMinutesSpaced)
        picker.selectRow(firstAccessInformationViewModel.initialTimeIndex.value, inComponent: 0, animated: false)
        picker.selectRow(firstAccessInformationViewModel.finalTimeIndex.value, inComponent: 1, animated: false)
        picker.rx.itemSelected.map { _ in
            return picker
        }.bind { [weak self] picker in
            self?.firstAccessInformationViewModel.initialTimeIndex.accept(picker.initialTimeIndex)
            self?.firstAccessInformationViewModel.finalTimeIndex.accept(picker.finalTimeIndex)
        }
            .disposed(by: disposeBag)
        return picker
    }()

	private lazy var shouldRemindSwitch = {
		let uiSwitch = SwitchWithLabel()
		uiSwitch.label.text = String(localized: "welcomeConfirmation.remindMe")
        uiSwitch.label.font = UIFont.h4
		uiSwitch.switchView.setOn(true, animated: false)
		uiSwitch.switchView.rx.controlEvent(.valueChanged)
			.withLatestFrom(uiSwitch.switchView.rx.value)
			.bind(to: firstAccessInformationViewModel.shouldRemind)
			.disposed(by: disposeBag)
		return uiSwitch
	}()

	let viewWrapper = UIView()

    static func newInstance(firstAccessInformationViewModel: FirstAccessInformationSharedViewModel) -> ConfirmationDailyConsumptionVC {
        ConfirmationDailyConsumptionVC(firstAccessInformationViewModel: firstAccessInformationViewModel)
    }

	override func viewWillAppear(_ animated: Bool) {
		firstAccessInformationViewModel.expectedWaterVolume
			.safeAsSingle()
			.subscribe(onSuccess: { expectedWaterVolume in
				switch expectedWaterVolume {
				case .successful(let waterQuantity):
					self.dailyWaterEditText.text = waterQuantity.toString()
				default:
					return
				}
			}).disposed(by: disposeBag)
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		firstAccessInformationViewModel.shouldRemind.subscribe(onNext : { [weak self] bool in
            self?.timePeriodSelector.isHidden = !bool
		}).disposed(by: disposeBag)

		firstAccessInformationViewModel.scheduleNotificationOnConfirmEvent.subscribe(onNext: { _ in
			self.requestNotificationPermisionThenSchedule()
		}).disposed(by: disposeBag)

		prepareHideKeyboardWhenTappedOut()
		prepareConfiguration()
		prepareConstraints()
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
		let waterVolume: Int = Int(waterVolumeInML()) // todo allow float
		self.firstAccessInformationViewModel.confirmWaterVolume(waterValue: waterVolume)
	}

	func waterVolumeInML() -> Float {
		let volume = self.dailyWaterEditText.text.unwrapLet { $0.toFloat() ?? 0 } ?? 0
		return currentVolumeFormat.toMetric(volume)
	}

	func waterVolumeTo(_ volumeFormat: VolumeFormat) -> Float {
		let volume = waterVolumeInML()
		return volumeFormat.fromMetric(volume)
	}

	func requestNotificationPermisionThenSchedule() {
		UNUserNotificationCenter.current().requestAuthorization(
			options: [.alert, .badge, .sound]
		) { _, _ in
			self.firstAccessInformationViewModel.scheduleReminderNotifications()
		}
	}
}
