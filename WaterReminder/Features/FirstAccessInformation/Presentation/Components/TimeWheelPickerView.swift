//
//  TimeWheelPickerView.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 08/06/23.
//

import Foundation
import UIKit

class TimeWheelPickerView: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
	
	let dayTime = Array(0...23).flatMap { hour in
		Array(0...3).map { minute in DayTime(hour: hour, minute: minute * 15) }
	}
	var valueChangeListener: ((TimeWheelPickerView) -> Void)?

	var dayTimeIndex = 8 * 4
	let rotationSelfAngle: CGFloat = -90  * (.pi/180)
	let rotationItemAngle: CGFloat = 90  * (.pi/180)
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		dataSource = self
		delegate = self
		selectRow(dayTimeIndex, inComponent: 0, animated: false)
		transform = CGAffineTransform(rotationAngle: rotationSelfAngle)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
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
			return dayTime[row].asString()
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
			label.font = UIFont.boldSystemFont(ofSize: 25.0)
		default:
			break
		}
		return label
	}

	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		switch component {
		case 0:
			dayTimeIndex = row
		default:
			break
		}
		valueChangeListener?(self)
	}
}

struct DayTime {
	let hour: Int
	let minute: Int

	func asString() -> String {
		return String(format: "%02d:%02d", hour, minute)
	}
}
