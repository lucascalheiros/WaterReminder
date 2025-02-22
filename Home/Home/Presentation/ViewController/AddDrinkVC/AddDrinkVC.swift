//
//  AddDrinkVC.swift
//  Home
//
//  Created by Lucas Calheiros on 09/02/25.
//

import UIKit
import WaterManagementDomain
import Components

class AddDrinkVC: UITableViewController {

    static func newInstance(addDrinkViewModel: AddDrinkViewModel) -> AddDrinkVC {
        AddDrinkVC(addDrinkViewModel: addDrinkViewModel)
    }

    let addDrinkViewModel: AddDrinkViewModel
    let delegate = ColorPickerDelegate()

    lazy var cancel = {
        let btn = UIBarButtonItem(title: String(localized: "generic.cancel"), primaryAction: .init(handler: { _ in
            self.dismiss(animated: true)
        }))
        btn.tintColor = DefaultComponentsTheme.current.background.onColor
        return btn
    }()

    lazy var confirm = {
        let btn = UIBarButtonItem(title: String(localized: "generic.confirm"), image: nil, primaryAction: .init(handler: { _ in
            self.addDrinkViewModel.save()
            self.dismiss(animated: true)
        }))
        btn.tintColor = DefaultComponentsTheme.current.background.onColor
        return btn
    }()

	init(addDrinkViewModel: AddDrinkViewModel) {
        self.addDrinkViewModel = addDrinkViewModel
		super.init(style: .insetGrouped)
		self.title = String(localized: "Add Drink")
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		prepareConfiguration()
		registerCells()
	}

	func prepareConfiguration() {
        view.backgroundColor = DefaultComponentsTheme.current.background.color
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = DefaultComponentsTheme.current.surface.onColor
        navigationItem.leftBarButtonItem = cancel
        navigationItem.rightBarButtonItem = confirm
	}

}
