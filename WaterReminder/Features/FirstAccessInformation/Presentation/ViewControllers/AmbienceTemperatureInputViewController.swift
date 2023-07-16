//
//  AmbienceTemperatureInputViewController.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 14/05/23.
//

import UIKit
import RxCocoa
import RxSwift

class AmbienceTemperatureInputViewController: BaseChildPageController {
	private let disposeBag = DisposeBag()

	private lazy var buttonsStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .horizontal
		stackView.alignment = .fill
		stackView.distribution = .fillEqually
		view.addSubview(stackView)
		return stackView
	}()
	
	private lazy var temperatureSegmentationControl = {
		let button =  UISegmentedControl(items: ["Cold","Moderate","Warm", "Hot"])
		button.selectedSegmentIndex = 1
		button.backgroundColor = Theme.lightTeal.mainColor
		let attributes = [
			NSAttributedString.Key.foregroundColor: UIColor.white,
			NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16.0)
		]
		button.setTitleTextAttributes(attributes, for: .normal)
		button.setTitleTextAttributes(attributes, for: .selected)
		button.selectedSegmentTintColor = .blue
		button.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(button)
		button.rx
			.value
			.map { index in
				AmbienceTemperatureLevel.allCases[index]
			}
			.bind(to: firstAccessInformationViewModel.temperatureLevel)
			.disposed(by: disposeBag)
		return button
	}()

	let informativeRange = ["less 20º", "20-25º", "26-30º", "more 30º"]

	override func viewDidLoad() {
		super.viewDidLoad()
		
		informativeMainText.text = "What is the average temperature in your region?"

		informativeRange.forEach { value in
			buttonsStackView.addArrangedSubview({
				let label = UILabel()
				label.textColor = .white
				label.text = value
				label.textAlignment = .center
				label.translatesAutoresizingMaskIntoConstraints = false
				return label
			}())
		}

		NSLayoutConstraint.activate([
			informativeMainText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			informativeMainText.bottomAnchor.constraint(equalTo: temperatureSegmentationControl.topAnchor),
			informativeMainText.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
			informativeMainText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			temperatureSegmentationControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			temperatureSegmentationControl.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			temperatureSegmentationControl.widthAnchor.constraint(equalTo: view.widthAnchor),
			buttonsStackView.topAnchor.constraint(equalTo: temperatureSegmentationControl.bottomAnchor, constant: 8),
			buttonsStackView.leadingAnchor.constraint(equalTo: temperatureSegmentationControl.leadingAnchor),
			buttonsStackView.trailingAnchor.constraint(equalTo: temperatureSegmentationControl.trailingAnchor)
		])
	}
}
