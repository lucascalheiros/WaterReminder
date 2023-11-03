//
//  AddWaterSourceVC.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 21/10/23.
//

import UIKit

class SelectWaterSourceTypeVC: UIViewController {

	private lazy var waterSourceTypePicker = WaterSourceTypePicker()
    private let waterSourceTypeSelector: WaterSourceTypeSelector

    init(_ defaultType: WaterSourceType, _ waterSourceTypeSelector: WaterSourceTypeSelector) {
        self.waterSourceTypeSelector = waterSourceTypeSelector
        super.init(nibName: nil, bundle: nil)
        self.waterSourceTypePicker.selectType(defaultType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
		prepareConfiguration()
		prepareConstraints()
	}

    override func viewDidDisappear(_ animated: Bool) {
        waterSourceTypeSelector.onWaterSourceTypeChange(waterSourceTypePicker.waterSourceType)
    }

	func prepareConfiguration() {
		view.backgroundColor = .white
	}

	func prepareConstraints() {
		view.addConstrainedSubviews(waterSourceTypePicker)

		NSLayoutConstraint.activate([
			waterSourceTypePicker.widthAnchor.constraint(equalTo: view.widthAnchor),
			waterSourceTypePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			waterSourceTypePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor)
		])
	}
	
}
