//
//  CreateWaterSourceItemVC.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 21/10/23.
//

import UIKit
import WaterManagementDomain
import RxRelay

class CreateWaterSourceItemVC: UITableViewController {

    var waterSourceType = BehaviorRelay(value: WaterSourceType.water)
    var waterWithFormat = BehaviorRelay(value: WaterWithFormat(waterInML: 500, volumeFormat: .metric))
    var createWaterSourceDelegate: CreateWaterSourceDelegate?

    lazy var cancel = {
        let btn = UIBarButtonItem(title: String(localized: "generic.cancel"), primaryAction: .init(handler: { _ in
            self.dismiss(animated: true)
        }))
        btn.tintColor = .white
        return btn
    }()

    lazy var confirm = {
        let btn = UIBarButtonItem(title: String(localized: "generic.confirm"), image: nil, primaryAction: .init(handler: { _ in
            self.createWaterSourceDelegate?.onCreateWaterSource(self.waterWithFormat.value.waterInML, self.waterSourceType.value)
            self.dismiss(animated: true)
        }))
        btn.tintColor = .white
        return btn
    }()

	init() {
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
		view.backgroundColor = .systemTeal
        navigationItem.leftBarButtonItem = cancel
        navigationItem.rightBarButtonItem = confirm
	}

}
