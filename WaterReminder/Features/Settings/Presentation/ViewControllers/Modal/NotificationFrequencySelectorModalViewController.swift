//
//  NotificationFrequencySelectorModalViewController.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 21/07/23.
//

import UIKit
import RxSwift
import RxCocoa

class NotificationFrequencySelectorModalViewController: UIViewController {
	var disposeBag = DisposeBag()

	let notificationFrequencySelectorDelegate: NotificationFrequencySelectorDelegate

	private lazy var notificationFrequencyPickerView = {
		let picker = NotificationFrequencyPickerView()
		return picker
	}()

	lazy var cancel = UIBarButtonItem(title: "Cancel", primaryAction: .init(handler: { _ in
		self.dismiss(animated: true)
	}))

	lazy var confirm = UIBarButtonItem(title: "Confirm", image: nil, primaryAction: .init(handler: { _ in
		let index = self.notificationFrequencyPickerView.selectedRow(inComponent: 0)
		self.notificationFrequencySelectorDelegate.setNotificationFrequency(
			frequency: self.notificationFrequencyPickerView.notificationFrequencyCases[index]
		)
		self.dismiss(animated: true)
	}))

	init(notificationFrequencySelectorDelegate: NotificationFrequencySelectorDelegate) {
		self.notificationFrequencySelectorDelegate = notificationFrequencySelectorDelegate
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		notificationFrequencySelectorDelegate.notificationFrequency.subscribe(
			onNext: {
				self.notificationFrequencyPickerView.selectRow($0.rawValue, inComponent: 0, animated: true)
			}
		).disposed(by: disposeBag)

		view.backgroundColor = Theme.lightBlue.mainColor
		cancel.tintColor = .blue
		confirm.tintColor = .blue

		navigationItem.leftBarButtonItem = cancel
		navigationItem.rightBarButtonItem = confirm

		view.addConstrainedSubviews(notificationFrequencyPickerView)

		NSLayoutConstraint.activate([
			notificationFrequencyPickerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			notificationFrequencyPickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
		])
	}

}
