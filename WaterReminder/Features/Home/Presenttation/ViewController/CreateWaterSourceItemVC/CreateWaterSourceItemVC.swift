//
//  CreateWaterSourceItemVC.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 21/10/23.
//

import UIKit

class CreateWaterSourceItemVC: UITableViewController {

    var waterSourceType = WaterSourceType.water
    var waterWithFormat = WaterWithFormat(waterInML: 500, volumeFormat: .metric)
    var createWaterSourceDelegate: CreateWaterSourceDelegate?

    lazy var cancel = {
        let btn = UIBarButtonItem(title: "Cancel", primaryAction: .init(handler: { _ in
            self.dismiss(animated: true)
        }))
        btn.tintColor = .white
        return btn
    }()

    lazy var confirm = {
        let btn = UIBarButtonItem(title: "Confirm", image: nil, primaryAction: .init(handler: { _ in
            self.createWaterSourceDelegate?.onCreateWaterSource(self.waterWithFormat.waterInML, self.waterSourceType)
            self.dismiss(animated: true)
        }))
        btn.tintColor = .white
        return btn
    }()

	init() {
		super.init(style: .insetGrouped)
		self.title = "Water Source"
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
