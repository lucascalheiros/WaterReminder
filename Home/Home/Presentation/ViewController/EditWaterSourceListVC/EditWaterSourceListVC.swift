//
//  EditWaterSourceVC.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 21/08/23.
//

import RxSwift
import UIKit
import WaterManagementDomain

class EditWaterSourceListVC: UITableViewController {

	let disposeBag = DisposeBag()

	private let getWaterSourceUseCase: GetWaterSourceUseCaseProtocol
    let manageWaterSourceUseCase: ManageWaterSourceUseCaseProtocol
	let reorderWaterSourceUseCase: ReorderWaterSourceUseCase
	lazy var waterSourceListObservable = { getWaterSourceUseCase.getWaterSourceListWithVolumeFormat() }()
	var waterSourceList: [WaterSourceSectionItems] = []
    var volumeFormat: VolumeFormat = VolumeFormat.metric

	init(
		getWaterSourceUseCase: GetWaterSourceUseCaseProtocol,
		reorderWaterSourceUseCase: ReorderWaterSourceUseCase,
        manageWaterSourceUseCase: ManageWaterSourceUseCaseProtocol
	) {
		self.getWaterSourceUseCase = getWaterSourceUseCase
		self.reorderWaterSourceUseCase = reorderWaterSourceUseCase
        self.manageWaterSourceUseCase = manageWaterSourceUseCase
		super.init(style: .insetGrouped)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    static func newInstance(
        getWaterSourceUseCase: GetWaterSourceUseCaseProtocol,
        reorderWaterSourceUseCase: ReorderWaterSourceUseCase,
        manageWaterSourceUseCase: ManageWaterSourceUseCaseProtocol
    ) -> EditWaterSourceListVC {
        EditWaterSourceListVC(getWaterSourceUseCase: getWaterSourceUseCase, reorderWaterSourceUseCase: reorderWaterSourceUseCase, manageWaterSourceUseCase: manageWaterSourceUseCase)
    }

	override func viewDidLoad() {
		super.viewDidLoad()

		prepareConfiguration()
		registerCells()
		configureDragAndDrop()
		loadTableData()
	}

	func prepareConfiguration() {
		view.backgroundColor = .systemTeal
	}


}

