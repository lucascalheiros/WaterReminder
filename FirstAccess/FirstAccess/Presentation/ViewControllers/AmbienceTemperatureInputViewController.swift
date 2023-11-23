//
//  AmbienceTemperatureInputViewController.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 14/05/23.
//

import UIKit
import RxCocoa
import RxSwift
import Core
import UserInformationDomain

class AmbienceTemperatureInputVC: BaseChildPageController {
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
		let button =  UISegmentedControl(items: [
            String(localized: "temperatureLevel.cold"),
            String(localized: "temperatureLevel.moderate"),
            String(localized: "temperatureLevel.warm"),
            String(localized: "temperatureLevel.hot")
        ])
		button.selectedSegmentIndex = 1
		button.backgroundColor = AppColorGroup.surface.color
		let attributes = [
			NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.body
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

	let informativeRange = [
        String(localized: "temperatureLevel.coldTemp"),
        String(localized: "temperatureLevel.moderateTemp"),
        String(localized: "temperatureLevel.warmTemp"),
        String(localized: "temperatureLevel.hotTemp")
    ]

    static func newInstance(firstAccessInformationViewModel: FirstAccessInformationSharedViewModel) -> AmbienceTemperatureInputVC {
        AmbienceTemperatureInputVC(firstAccessInformationViewModel: firstAccessInformationViewModel)
    }

	override func viewDidLoad() {
		super.viewDidLoad()
		
		informativeMainText.text = String(localized: "temperatureLevel.mainText")

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
