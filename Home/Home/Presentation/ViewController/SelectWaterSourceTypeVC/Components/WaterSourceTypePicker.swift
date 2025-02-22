//
//  WaterSourceTypePicker.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 21/10/23.
//

import UIKit
import WaterManagementDomain

class WaterSourceTypePicker: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
	
    var onDrinkSelected: ((Drink) -> Void)?
    var drink: Drink?
    var drinks = [Drink]()

	override init(frame: CGRect) {
		super.init(frame: frame)
		dataSource = self
		delegate = self
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    func selectType(_ drink: Drink, animated: Bool = false) {
        self.drink = drink
        selectRow(drinks.firstIndex(of: drink) ?? 0, inComponent: 0, animated: animated)
    }

	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}

	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		if component == 0 {
			return drinks.count
		} else {
			return 0
		}
	}

	func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
		let drink = drinks[row]
		let label = view as? UILabel ?? UILabel()
		label.text = drink.name
		label.textColor = drink.color
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
        let drink = drinks[row]
        self.drink = drink
        self.onDrinkSelected?(drink)
    }
}
