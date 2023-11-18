//
//  WaterSourceTypePicker.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 21/10/23.
//

import UIKit

class WaterSourceTypePicker: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
	
    var listener: WaterSourceTypeSelector?
    var waterSourceType: WaterSourceType = .water

	override init(frame: CGRect) {
		super.init(frame: frame)
		dataSource = self
		delegate = self
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    func selectType(_ type: WaterSourceType, animated: Bool = false) {
        waterSourceType = type
        selectRow(WaterSourceType.allCases.firstIndex(of: type) ?? 0, inComponent: 0, animated: animated)
    }

	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}

	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		if component == 0 {
			return WaterSourceType.allCases.count
		} else {
			return 0
		}
	}

	func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
		let waterSourceType = WaterSourceType.allCases[row]
		let label = view as? UILabel ?? UILabel()
		label.text = waterSourceType.exhibitionName
		label.textColor = waterSourceType.color
		label.textAlignment = .center
		switch component {
		case 0:
            label.font = .h2
		default:
			break
		}
		return label
	}

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let type = WaterSourceType.allCases[row]
        waterSourceType = type
        listener?.onWaterSourceTypeChange(type)
    }
}

protocol WaterSourceTypeSelector {
    func onWaterSourceTypeChange(_ type: WaterSourceType)
}
