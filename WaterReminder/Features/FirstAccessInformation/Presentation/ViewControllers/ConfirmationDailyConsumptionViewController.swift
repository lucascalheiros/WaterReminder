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

	let disposeBag = DisposeBag()

	lazy var dailyWaterEditText = {
		let text = DailyWaterInputField()
		return text
	}()

	private lazy var confirmationBtn = {
		let button = UIButton()
		button.setTitle("Confirm", for: .normal)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
//		button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(skipButtonClick)))
		return button
	}()

	private lazy var initialNotificationTime = {
		let picker = TimeWheelPickerView()
		picker.selectRow(8 * 4, inComponent: 0, animated: false)
		picker.valueChangeListener = { _ in
			self.limitInitialPickerValue()
		}
		return picker
	}()

	private lazy var finalNotificationTime = {
		let picker = TimeWheelPickerView()
		picker.selectRow(20 * 4, inComponent: 0, animated: false)
		picker.valueChangeListener = { _ in
			self.limitFinalPickerValue()
		}
		return picker
	}()

	func limitInitialPickerValue() {
		if (initialNotificationTime.dayTimeIndex > finalNotificationTime.dayTimeIndex) {
			finalNotificationTime.selectRow(initialNotificationTime.dayTimeIndex, inComponent: 0, animated: true)
		}
	}

	func limitFinalPickerValue() {
		if (finalNotificationTime.dayTimeIndex < initialNotificationTime.dayTimeIndex) {
			initialNotificationTime.selectRow(finalNotificationTime.dayTimeIndex, inComponent: 0, animated: true)
		}
	}
	private lazy var shouldRemindSwitch = {
		let uiSwitch = SwitchWithLabel()
		uiSwitch.label.text = "I want to be reminded"
		uiSwitch.switchView.setOn(true, animated: false)
		uiSwitch.switchView
			.rx
			.controlEvent(.valueChanged)
			.withLatestFrom(uiSwitch.switchView.rx.value)
			.subscribe(onNext : { bool in
				self.initialNotificationTime.isHidden = !bool
				self.finalNotificationTime.isHidden = !bool
			})
			.disposed(by: disposeBag)
		return uiSwitch
	}()

	let viewWrapper = UIView()

	override func viewDidLoad() {
		super.viewDidLoad()

		prepareHideKeyboardWhenTappedOut()
		prepareConfiguration()
		prepareConstraints()
	}

	func prepareConfiguration() {
		informativeMainText.text = "Confirm the amount of daily water you want to ingest, and confirm the notification interval we should use for the reminders."
		skipEstimativeButton.isHidden = true
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

	func offsetForRotation(_ finalWidth: CGFloat, _ finalHeight: CGFloat) -> CGFloat {
		-(finalWidth - finalHeight) / 2
	}
}
