//
//  PeriodSelectorModalViewController.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 21/07/23.
//

import UIKit
import RxSwift
import RxCocoa

class PeriodSelectorModalViewController: UIViewController {
	var disposeBag = DisposeBag()

	let periodSelectorDelegate: PeriodSelectorDelegate

	let timePeriodFifteenMinutesSpaced = Array(0...23).flatMap { hour in
		Array(0...3).map { minute in TimePeriod(hour: hour, minute: minute * 15) }
	}

	private lazy var initialNotificationTime = {
		let picker = TimeWheelPickerView()
		picker.updateData(dayTime: timePeriodFifteenMinutesSpaced)
		picker.rx
			.itemSelected
			.map { _ in
				self.limitInitialPickerValue()
				return picker.selectedIndex
			}
			.bind(to: initialTimeIndex)
			.disposed(by: disposeBag)
		return picker
	}()

	private lazy var finalNotificationTime = {
		let picker = TimeWheelPickerView()
		picker.updateData(dayTime: timePeriodFifteenMinutesSpaced)
		picker.rx
			.itemSelected
			.map { _ in
				self.limitFinalPickerValue()
				return picker.selectedIndex
			}
			.bind(to: finalTimeIndex)
			.disposed(by: disposeBag)
		return picker
	}()

	lazy var initialTimeIndex = BehaviorRelay<Int>(value: 0)
	lazy var finalTimeIndex = BehaviorRelay<Int>(value: 0)

	lazy var cancel = UIBarButtonItem(title: String(localized: "generic.cancel"), primaryAction: .init(handler: { _ in
		self.dismiss(animated: true)
	}))

	lazy var confirm = UIBarButtonItem(title: String(localized: "generic.confirm"), image: nil, primaryAction: .init(handler: { _ in
		let startTime = self.timePeriodFifteenMinutesSpaced[self.initialTimeIndex.value]
		let endTime = self.timePeriodFifteenMinutesSpaced[self.finalTimeIndex.value]
		self.periodSelectorDelegate.setNotificationPeriod(startTime: startTime, endTime: endTime)
		self.dismiss(animated: true)
	}))

	init(periodSelectorDelegate: PeriodSelectorDelegate) {
		self.periodSelectorDelegate = periodSelectorDelegate
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		periodSelectorDelegate.initialTime.subscribe(
			onNext: { time in
				let index = self.timeToIndex(time)
				self.initialTimeIndex.accept(index)
				self.initialNotificationTime.selectRow(self.timeToIndex(time), inComponent: 0, animated: true)
			}
		).disposed(by: disposeBag)

		periodSelectorDelegate.finalTime.subscribe(
			onNext: { time in
				let index = self.timeToIndex(time)
				self.finalTimeIndex.accept(index)
				self.finalNotificationTime.selectRow(index, inComponent: 0, animated: true)
			}
		).disposed(by: disposeBag)

		view.backgroundColor = Theme.lightBlue.mainColor
		cancel.tintColor = .blue
		confirm.tintColor = .blue

		navigationItem.leftBarButtonItem = cancel
		navigationItem.rightBarButtonItem = confirm

		view.addConstrainedSubviews(initialNotificationTime, finalNotificationTime)

		NSLayoutConstraint.activate([
			initialNotificationTime.centerYAnchor.constraint(
				equalTo: view.centerYAnchor,
				constant: offsetForRotation(300, 75) + 75),
			initialNotificationTime.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			initialNotificationTime.widthAnchor.constraint(equalToConstant: 75),
			initialNotificationTime.heightAnchor.constraint(equalToConstant: 300),

			finalNotificationTime.centerYAnchor.constraint(
				equalTo: view.centerYAnchor,
				constant: offsetForRotation(300, 75) + 150),
			finalNotificationTime.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			finalNotificationTime.widthAnchor.constraint(equalToConstant: 75),
			finalNotificationTime.heightAnchor.constraint(equalToConstant: 300)
		])
	}

	func timeToIndex(_ time: TimePeriod) -> Int {
		self.timePeriodFifteenMinutesSpaced.firstIndex { time == $0 } ?? 0
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
