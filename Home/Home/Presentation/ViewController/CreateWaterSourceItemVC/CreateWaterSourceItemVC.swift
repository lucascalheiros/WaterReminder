//
//  CreateWaterSourceItemVC.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 21/10/23.
//

import UIKit
import WaterManagementDomain
import RxRelay
import Components

class CreateWaterSourceItemVC: UITableViewController {

    static func newInstance(createWaterSourceItemViewModel: CreateWaterSourceItemViewModel) -> CreateWaterSourceItemVC {
        CreateWaterSourceItemVC(createWaterSourceItemViewModel: createWaterSourceItemViewModel)
    }

    let createWaterSourceItemViewModel: CreateWaterSourceItemViewModel

    lazy var cancel = {
        let btn = UIBarButtonItem(title: String(localized: "generic.cancel"), primaryAction: .init(handler: { _ in
            self.dismiss(animated: true)
        }))
        btn.tintColor = DefaultComponentsTheme.current.background.onColor
        return btn
    }()

    lazy var confirm = {
        let btn = UIBarButtonItem(title: String(localized: "generic.confirm"), image: nil, primaryAction: .init(handler: { _ in
            self.createWaterSourceItemViewModel.saveWaterSource()
            self.dismiss(animated: true)
        }))
        btn.tintColor = DefaultComponentsTheme.current.background.onColor
        return btn
    }()

	init(createWaterSourceItemViewModel: CreateWaterSourceItemViewModel) {
        self.createWaterSourceItemViewModel = createWaterSourceItemViewModel
		super.init(style: .insetGrouped)
		self.title = String(localized: "createWaterSource.screenTitle")
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
