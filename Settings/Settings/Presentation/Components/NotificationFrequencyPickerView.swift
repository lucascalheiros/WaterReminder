//
//  NotificationFrequencyPickerView.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 02/08/23.
//

import UIKit
import WaterReminderNotificationDomain

class NotificationFrequencyPickerView: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {

	let notificationFrequencyCases = NotificationFrequencyEnum.allCases

	override init(frame: CGRect) {
		super.init(frame: frame)
		dataSource = self
		delegate = self
		selectRow(NotificationFrequencyEnum.medium.rawValue, inComponent: 0, animated: false)
	}

	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		notificationFrequencyCases[row].stringValue()
	}

	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		1
	}

	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		notificationFrequencyCases.count
	}


	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}
