//
//  EditWaterSourceVC.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 21/08/23.
//

import RxSwift
import UIKit
import WaterManagementDomain
import Combine

class EditWaterSourceListVC: UITableViewController {

    static func newInstance(
        editWaterSourceListViewModel: EditWaterSourceListViewModel
    ) -> EditWaterSourceListVC {
        EditWaterSourceListVC(editWaterSourceListViewModel: editWaterSourceListViewModel)
    }

	let disposeBag = DisposeBag()
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
		view.backgroundColor = .systemTeal
        registerCells()
        configureDragAndDrop()
	}
}
