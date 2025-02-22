//
//  EditWaterSourceVC.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 21/08/23.
//

import UIKit
import WaterManagementDomain
import Combine
import Core
import Components

class EditWaterSourceListVC: UITableViewController {

    static func newInstance(
        editWaterSourceListViewModel: EditWaterSourceListViewModel
    ) -> EditWaterSourceListVC {
        EditWaterSourceListVC(editWaterSourceListViewModel: editWaterSourceListViewModel)
    }

    var cancellableBag = Set<AnyCancellable>()

    let editWaterSourceListViewModel: EditWaterSourceListViewModel

	init(
        editWaterSourceListViewModel: EditWaterSourceListViewModel
	) {
        self.editWaterSourceListViewModel = editWaterSourceListViewModel
		super.init(style: .insetGrouped)
        title = String(localized: "Water Source Manager")
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		prepareConfiguration()
		observeViewModel()
	}

	func prepareConfiguration() {
        view.backgroundColor = AppColorGroup.background.color
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = DefaultComponentsTheme.current.surface.onColor
        registerCells()
        configureDragAndDrop()
	}
}
