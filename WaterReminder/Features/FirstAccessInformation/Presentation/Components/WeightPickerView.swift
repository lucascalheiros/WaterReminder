//
//  WeightPickerView.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 28/05/23.
//

import Foundation
import UIKit

class WeightPickerView: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
	
	let weightInteger = Array(1...500)
	let weightFractional = Array(0...9)
	let weightFormat = WeightFormat.allCases
	var valueChangeListener: ((WeightPickerView) -> Void)? = nil

	var selectedWeightInteger = 69
	var selectedWeightFraction = 0
	var selectedWeightFormat = WeightFormat.metric
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		dataSource = self
		delegate = self
		selectRow(selectedWeightInteger, inComponent: 0, animated: false)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		3
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		switch component {
		case 0:
			return weightInteger.count
		case 1:
			return weightFractional.count
		case 2:
			return weightFormat.count
		default:
			return 0
		}
	}
	
	func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
		switch component {
		case 0:
			return 70
		case 1:
			return 40
		case 2:
			return 40
		default:
			return 0
		}
	}
	
	func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
		switch component {
		case 0:
			return 120
		case 1:
			return 60
		case 2:
			return 60
		default:
			return 0
		}
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		switch component {
		case 0:
			return String(weightInteger[row])
		case 1:
			return "." + String(weightFractional[row])
		case 2:
			return weightFormat[row].displayString
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
		switch component {
		case 0:
			label.font = UIFont.boldSystemFont(ofSize: 60.0)
		case 1:
			label.font = UIFont.boldSystemFont(ofSize: 40.0)
		case 2:
			label.font = UIFont.boldSystemFont(ofSize: 30.0)
		default:
			break
		}
		return label
	}

	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		switch component {
		case 0:
			selectedWeightInteger = weightInteger[row]
		case 1:
			selectedWeightFraction = weightFractional[row]
		case 2:
			selectedWeightFormat = weightFormat[row]
		default:
			break
		}
		valueChangeListener?(self)
	}
}
