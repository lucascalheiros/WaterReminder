//
//  ConfirmationDailyConsumptionViewController.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 14/05/23.
//

import UIKit

class ConfirmationDailyConsumptionViewController: BaseChildPageController {
	lazy var expectedDailyWaterLabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.boldSystemFont(ofSize: 26)
		label.textColor = .blue
		label.numberOfLines = 0
		label.textAlignment = .center
		view.addSubview(label)
		return label
	}()

	lazy var chooseDailyWaterLabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.boldSystemFont(ofSize: 20)
		label.textColor = .white
		view.addSubview(label)
		return label
	}()

	lazy var dailyWaterEditText = {
		let text = DailyWaterInputField()
		text.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(text)
		return text
	}()

	private lazy var confirmationBtn = {
		let button = UIButton()
		button.setTitle("Confirm", for: .normal)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
		button.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(button)
//		button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(skipButtonClick)))
		return button
	}()

	override func viewDidLoad() {
		super.viewDidLoad()

		expectedDailyWaterLabel.text = "123556"
		chooseDailyWaterLabel.text = "Choose the amount"
		informativeMainText.text = "Your estimated amount of daily water consumption is"

		prepareHideKeyboardWhenTappedOut()

		let viewWrapper = UIView()
		viewWrapper.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(viewWrapper)

		NSLayoutConstraint.activate([
			dailyWaterEditText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			dailyWaterEditText.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			dailyWaterEditText.widthAnchor.constraint(equalToConstant: 150),
			dailyWaterEditText.heightAnchor.constraint(equalToConstant: 60),
			chooseDailyWaterLabel.bottomAnchor.constraint(equalTo: dailyWaterEditText.topAnchor),
			chooseDailyWaterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			viewWrapper.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			viewWrapper.bottomAnchor.constraint(equalTo: chooseDailyWaterLabel.topAnchor),
			viewWrapper.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			viewWrapper.widthAnchor.constraint(equalTo: view.widthAnchor),
			informativeMainText.centerYAnchor.constraint(equalTo: viewWrapper.centerYAnchor),
			informativeMainText.centerXAnchor.constraint(equalTo: viewWrapper.centerXAnchor),
			informativeMainText.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
			expectedDailyWaterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			expectedDailyWaterLabel.topAnchor.constraint(equalTo: informativeMainText.bottomAnchor),
			confirmationBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
			confirmationBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor)
		])
	}

}

extension UIViewController {
	func prepareHideKeyboardWhenTappedOut() {
		let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
		tap.cancelsTouchesInView = false
		view.addGestureRecognizer(tap)
	}

	@objc func dismissKeyboard() {
		view.endEditing(true)
	}
}
