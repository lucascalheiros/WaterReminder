//
//  ActivityLevelInputViewController.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 14/05/23.
//

import UIKit
import RxCocoa
import RxSwift
import UserInformationDomain
import Combine

class ActivityLevelInputVC: BaseChildPageController {

    var cancellableBag = Set<AnyCancellable>()

	private let disposeBag = DisposeBag()

    private lazy var cardStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        view.addConstrainedSubview(stackView)
        return stackView
    }()

    static func newInstance(firstAccessInformationViewModel: FirstAccessInformationSharedViewModel) -> ActivityLevelInputVC {
        ActivityLevelInputVC(firstAccessInformationViewModel: firstAccessInformationViewModel)
    }

	override func viewDidLoad() {
		super.viewDidLoad()
		
        informativeMainText.text = String(localized: "activityLevel.mainText")

        ActivityLevel.allCases.forEach { activityLevel in
            let cardView = ActivityLevelCardView(
                title: activityLevel.title,
                description: activityLevel.description
            )
            cardView.addTapListener { [weak self] in
                self?.firstAccessInformationViewModel.setActivityLevel(activityLevel)
            }
            firstAccessInformationViewModel.$activityLevel.sinkUI {
                cardView.isSelected = activityLevel == $0
            }.store(in: &cancellableBag)
            cardStackView.addConstrainedArrangedSubview(cardView)
        }

		NSLayoutConstraint.activate([
			informativeMainText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			informativeMainText.bottomAnchor.constraint(equalTo: cardStackView.topAnchor, constant: -16),
			informativeMainText.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
			informativeMainText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardStackView.topAnchor.constraint(equalTo: informativeMainText.bottomAnchor, constant: 16),
            cardStackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
            cardStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
		])
	}
}
class IntParameterUITapGestureRecognizer: UITapGestureRecognizer {
	var value: Int?

	init(target: AnyObject, action: Selector, value: Int? = nil) {
		self.value = value
		super.init(target: target, action: action)
	}
}
