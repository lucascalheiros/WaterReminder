//
//  WeightInputViewController.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 14/05/23.
//

import UIKit

class WeightInputViewController: BaseChildPageController {	
	
	lazy var weightPicker = {
		let picker = WeightPickerView()
		picker.translatesAutoresizingMaskIntoConstraints = false
		picker.valueChangeListener = {
			$0
		}
		view.addSubview(picker)
		return picker
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		informativeMainText.text = "Your weight is an important factor to estimate your necessary water consumption"

		NSLayoutConstraint.activate([
			informativeMainText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			informativeMainText.bottomAnchor.constraint(equalTo: weightPicker.topAnchor),
			informativeMainText.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
			informativeMainText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			weightPicker.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
			weightPicker.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
		])
	}

}
