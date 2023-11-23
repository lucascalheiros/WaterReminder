//
//  WeightInputViewController.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 14/05/23.
//

import UIKit
import RxCocoa
import RxSwift

class WeightInputVC: BaseChildPageController {
	private let disposeBag = DisposeBag()
	
	lazy var weightPicker = {
		let picker = WeightPickerView()
		picker.rx
			.itemSelected
			.map { _ in
				picker.selectedWeightInfo
			}
			.bind(to: firstAccessInformationViewModel.weightInfo)
			.disposed(by: disposeBag)
		return picker
	}()

    static func newInstance(firstAccessInformationViewModel: FirstAccessInformationSharedViewModel) -> WeightInputVC {
        WeightInputVC(firstAccessInformationViewModel: firstAccessInformationViewModel)
    }

	override func viewDidLoad() {
		super.viewDidLoad()

		view.addConstrainedSubview(weightPicker)
		
		informativeMainText.text = String(localized: "weight.mainText")

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
