//
//  AddWaterSourceVC.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 21/10/23.
//

import UIKit
import Core
import WaterManagementDomain
import Components

class SelectWaterSourceTypeVC: UIViewController {

	private lazy var waterSourceTypePicker = WaterSourceTypePicker()

    var onDrinkSelected: ((Drink) -> Void)?

    var drinks = [Drink]()

    init(_ drink: Drink, _ drinks: [Drink]) {
        self.drinks = drinks
        super.init(nibName: nil, bundle: nil)
        self.waterSourceTypePicker.drinks = drinks
        self.waterSourceTypePicker.selectType(drink)
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
        guard let drink = waterSourceTypePicker.drink else {
            return
        }
        onDrinkSelected?(drink)
    }

	func prepareConfiguration() {
        view.backgroundColor = DefaultComponentsTheme.current.surface.color
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
