//
//  TimeWheelPickerView.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 08/06/23.
//

import Foundation
import UIKit

class TimeWheelPickerView: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
	
	var dayTime: [TimePeriod] = Array()
	var valueChangeListener: ((TimeWheelPickerView) -> Void)?

	var selectedIndex: Int = 0
	let rotationSelfAngle: CGFloat = -90  * (.pi/180)
	let rotationItemAngle: CGFloat = 90  * (.pi/180)
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		dataSource = self
		delegate = self
		transform = CGAffineTransform(rotationAngle: rotationSelfAngle)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func updateData(dayTime: [TimePeriod]) {
		self.dayTime = dayTime
		reloadComponent(0)
	}

	override func selectRow(_ row: Int, inComponent: Int, animated: Bool) {
		selectedIndex = row
		super.selectRow(row, inComponent: inComponent, animated: animated)
	}
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		switch component {
		case 0:
			return dayTime.count
		default:
			return 0
		}
	}
	
	func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
		switch component {
		case 0:
			return 75
		default:
			return 0
		}
	}

	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		switch component {
		case 0:
			return dayTime[row].hourAndMinuteAsString()
		default:
			return ""
		}
	}
	
	func pickerView(
		_ pickerView: UIPickerView,
		viewForRow row: Int,
		forComponent component: Int,
		reusing view: UIView?
	) -> UIView {
		let string = self.pickerView(pickerView, titleForRow: row, forComponent: component) ?? ""
		let label = view as? UILabel ?? UILabel()
		label.text = string
		label.textColor = .white
		label.textAlignment = .center
		label.transform = CGAffineTransform(rotationAngle: rotationItemAngle)
		switch component {
		case 0:
            label.font = .h3
		default:
			break
		}
		return label
	}

	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		switch component {
		case 0:
			selectedIndex = row
		default:
			break
		}
		valueChangeListener?(self)
	}
}

extension TimePeriod {
	func hourAndMinuteAsString() -> String {
		return String(format: "%02d:%02d", hour, minute)
	}
}
