//
//  NotificationFrequencySelectorModalVC.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 21/07/23.
//

import UIKit
import RxSwift
import RxCocoa
import Core
import Combine

class NotificationFrequencySelectorModalVC: UIViewController {
	var disposeBag = DisposeBag()
    var bag = Set<AnyCancellable>()

	let notificationFrequencySelectorDelegate: NotificationFrequencySelectorDelegate

	private lazy var notificationFrequencyPickerView = {
		let picker = NotificationFrequencyPickerView()
		return picker
	}()

	lazy var cancel = UIBarButtonItem(title: String(localized: "generic.cancel"), primaryAction: .init(handler: { _ in
		self.dismiss(animated: true)
	}))

	lazy var confirm = UIBarButtonItem(title: String(localized: "generic.confirm"), image: nil, primaryAction: .init(handler: { _ in
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

		notificationFrequencySelectorDelegate.notificationFrequency.sink {
				self.notificationFrequencyPickerView.selectRow($0.rawValue, inComponent: 0, animated: true)
        }.store(in: &bag)

		view.backgroundColor = AppColorGroup.primary.color
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
