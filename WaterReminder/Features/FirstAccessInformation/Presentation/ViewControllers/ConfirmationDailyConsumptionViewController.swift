//
//  ConfirmationDailyConsumptionViewController.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 14/05/23.
//

import UIKit
import RxSwift
import RxCocoa

class ConfirmationDailyConsumptionViewController: BaseChildPageController {
	private let disposeBag = DisposeBag()

	private lazy var dailyWaterEditText = {
		let text = DailyWaterInputField()
		return text
	}()

	private lazy var confirmationBtn = {
		let button = UIButton()
		button.setTitle("Confirm", for: .normal)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
		button
			.rx
			.tap
			.bind {
				let waterVolume: Int = self.dailyWaterEditText.text.unwrapLet { $0.toInt() ?? 0 } ?? 0
				self.firstAccessInformationViewModel.confirmWaterVolume(waterValue: waterVolume)
			}
			.disposed(by: disposeBag)
		return button
	}()

	private lazy var initialNotificationTime = {
		let picker = TimeWheelPickerView()
		picker.updateData(dayTime: firstAccessInformationViewModel.timePeriodFifteenMinutesSpaced)
		picker.selectRow(firstAccessInformationViewModel.initialTimeIndex.value, inComponent: 0, animated: false)
		picker.rx
			.itemSelected
			.map { _ in
				self.limitInitialPickerValue()
				return picker.selectedIndex
			}
			.bind(to: firstAccessInformationViewModel.initialTimeIndex)
			.disposed(by: disposeBag)
		return picker
	}()

	private lazy var finalNotificationTime = {
		let picker = TimeWheelPickerView()
		picker.updateData(dayTime: firstAccessInformationViewModel.timePeriodFifteenMinutesSpaced)
		picker.selectRow(firstAccessInformationViewModel.finalTimeIndex.value, inComponent: 0, animated: false)
		picker.rx
			.itemSelected
			.map { _ in
				self.limitFinalPickerValue()
				return picker.selectedIndex
			}
			.bind(to: firstAccessInformationViewModel.finalTimeIndex)
			.disposed(by: disposeBag)
		return picker
	}()

	private lazy var shouldRemindSwitch = {
		let uiSwitch = SwitchWithLabel()
		uiSwitch.label.text = "I want to be reminded"
		uiSwitch.switchView.setOn(true, animated: false)
		uiSwitch.switchView
			.rx
			.controlEvent(.valueChanged)
			.withLatestFrom(uiSwitch.switchView.rx.value)
			.bind(to: firstAccessInformationViewModel.shouldRemind)
			.disposed(by: disposeBag)
		return uiSwitch
	}()

	let viewWrapper = UIView()

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

		firstAccessInformationViewModel.shouldRemind.subscribe(onNext : { bool in
			self.initialNotificationTime.isHidden = !bool
			self.finalNotificationTime.isHidden = !bool
		})
		.disposed(by: disposeBag)

		prepareHideKeyboardWhenTappedOut()
		prepareConfiguration()
		prepareConstraints()
	}

	func prepareConfiguration() {
		informativeMainText.text = "Confirm the amount of daily water you want to ingest, and confirm the notification interval we should use for the reminders."
//		skipEstimativeButton.isHidden = true
	}

	func prepareConstraints() {
		view.addConstrainedSubviews(
			viewWrapper,
			dailyWaterEditText,
			confirmationBtn,
			initialNotificationTime,
			finalNotificationTime,
			shouldRemindSwitch
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
			dailyWaterEditText.widthAnchor.constraint(equalToConstant: 150),
			dailyWaterEditText.heightAnchor.constraint(equalToConstant: 60),

			initialNotificationTime.bottomAnchor.constraint(equalTo: shouldRemindSwitch.topAnchor, constant: -offsetForRotation(300, 75) - 91),
			initialNotificationTime.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			initialNotificationTime.widthAnchor.constraint(equalToConstant: 75),
			initialNotificationTime.heightAnchor.constraint(equalToConstant: 300),

			finalNotificationTime.bottomAnchor.constraint(equalTo: shouldRemindSwitch.topAnchor, constant: -offsetForRotation(300, 75) - 16),
			finalNotificationTime.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			finalNotificationTime.widthAnchor.constraint(equalToConstant: 75),
			finalNotificationTime.heightAnchor.constraint(equalToConstant: 300),

			shouldRemindSwitch.bottomAnchor.constraint(equalTo: confirmationBtn.topAnchor, constant: -32),
			shouldRemindSwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			shouldRemindSwitch.widthAnchor.constraint(equalToConstant: 300),

			confirmationBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
			confirmationBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor)
		])
	}

	func limitInitialPickerValue() {
		if (initialNotificationTime.selectedIndex > finalNotificationTime.selectedIndex) {
			finalNotificationTime.selectRow(initialNotificationTime.selectedIndex, inComponent: 0, animated: true)
		}
	}

	func limitFinalPickerValue() {
		if (finalNotificationTime.selectedIndex < initialNotificationTime.selectedIndex) {
			initialNotificationTime.selectRow(finalNotificationTime.selectedIndex, inComponent: 0, animated: true)
		}
	}

	func offsetForRotation(_ finalWidth: CGFloat, _ finalHeight: CGFloat) -> CGFloat {
		-(finalWidth - finalHeight) / 2
	}
}
