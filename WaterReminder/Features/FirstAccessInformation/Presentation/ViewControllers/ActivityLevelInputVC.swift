//
//  ActivityLevelInputViewController.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 14/05/23.
//

import UIKit
import RxCocoa
import RxSwift

class ActivityLevelInputVC: BaseChildPageController {
	private let disposeBag = DisposeBag()

	lazy var activityLevelSlider = {
		let slider = ActivitySliderView()
		slider.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(slider)
		slider.addTarget(self, action: #selector(self.sliderValueDidChange(_:)), for: .valueChanged)
		slider.addGestureRecognizer(
			UITapGestureRecognizer(target: self, action: #selector(sliderTapped(gestureRecognizer:)))
		)
		return slider
	}()
	
	private lazy var sliderLabelStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .horizontal
		stackView.alignment = .fill
		stackView.distribution = .fillEqually
		stackView.spacing = 20
		view.addSubview(stackView)
		return stackView
	}()
	
	let weekNumber = Array(0 ... 7)
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
        informativeMainText.text = String(localized: "activityLevel.mainText")

		weekNumber.forEach { number in
			sliderLabelStackView.addArrangedSubview({
				let label = UILabel()
				label.textColor = .white
				label.text = String(number)
				label.textAlignment = .center
				label.translatesAutoresizingMaskIntoConstraints = false
				label.addGestureRecognizer(
					IntParameterUITapGestureRecognizer(target: self, action: #selector(numberTapped), value: number)
				)
				label.isUserInteractionEnabled = true
				view.bringSubviewToFront(label)
				return label
			}())
		}
		
		NSLayoutConstraint.activate([
			informativeMainText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			informativeMainText.bottomAnchor.constraint(equalTo: activityLevelSlider.topAnchor),
			informativeMainText.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
			informativeMainText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			activityLevelSlider.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
			activityLevelSlider.heightAnchor.constraint(equalToConstant: 60),
			activityLevelSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			activityLevelSlider.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			sliderLabelStackView.topAnchor.constraint(equalTo: activityLevelSlider.bottomAnchor, constant: 8),
			sliderLabelStackView.leadingAnchor.constraint(equalTo: activityLevelSlider.leadingAnchor),
			sliderLabelStackView.trailingAnchor.constraint(equalTo: activityLevelSlider.trailingAnchor)
		])
	}
	
	@objc func sliderValueDidChange(_ sender: UISlider!) {
		let roundedStepValue = round(sender.value / 1)
		sender.value = roundedStepValue
	}
	
	@objc func sliderTapped(gestureRecognizer: UIGestureRecognizer) {
		let pointTapped: CGPoint = gestureRecognizer.location(in: view)
		
		let positionOfSlider: CGPoint = activityLevelSlider.frame.origin
		let widthOfSlider: CGFloat = activityLevelSlider.frame.size.width
		let newValue = ((pointTapped.x - positionOfSlider.x) * CGFloat(activityLevelSlider.maximumValue) /
						widthOfSlider)
		let roundedStepValue = Float(round(newValue / 1))

		activityLevelSlider.setValue(roundedStepValue, animated: true)
		self.firstAccessInformationViewModel.exerciseDays.accept(Float(roundedStepValue))

	}

	@objc func numberTapped(_ sender: IntParameterUITapGestureRecognizer) {
		if let value = sender.value {
			activityLevelSlider.setValue(Float(value), animated: true)
			self.firstAccessInformationViewModel.exerciseDays.accept(Float(value))
		}
	}
}
class IntParameterUITapGestureRecognizer: UITapGestureRecognizer {
	var value: Int?

	init(target: AnyObject, action: Selector, value: Int? = nil) {
		self.value = value
		super.init(target: target, action: action)
	}
}
