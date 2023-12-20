//
//  EditWaterSourceListVC+Datasource.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 20/10/23.
//

import RxSwift
import UIKit
import WaterManagementDomain

extension EditWaterSourceListVC {
	override func tableView(_ tableView: UITableView, numberOfRowsInSection sectionIndex: Int) -> Int {
		switch Sections.allCases[safe: sectionIndex] {
		case .main:
			return editWaterSourceListViewModel.exhibitionList.count

		default:
			return 0
		}
	}

	override func numberOfSections(in tableView: UITableView) -> Int {
        Sections.allCases.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		switch Sections.allCases[safe: indexPath.section] {
		case .main:
			return getCellForMainSection(tableView, indexPath)

		default:
			fatalError("Section not implemented")
		}
	}

	func registerCells() {
        tableView.registerIdentifiableCell(WaterSourceEditableCell.self)
        tableView.registerIdentifiableCell(AddWaterSourceCell.self)
	}

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch getItemForIndexPath(indexPath) {
        case .add:
            editWaterSourceListViewModel.showCreateWaterSource()

        default:
            break
        }
    }

    func getItemForIndexPath(_ indexPath: IndexPath) -> EditWaterSourceListViewModel.WaterSourceSectionItems? {
		switch Sections.allCases[safe: indexPath.section] {
		case .main:
			return editWaterSourceListViewModel.exhibitionList[safe: indexPath.row]

		default:
			return nil
		}
	}

	func getCellForMainSection(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
		switch getItemForIndexPath(indexPath) {
		case .waterSourceItem(let waterSource):
            return tableView.dequeueIdentifiableCell(indexPath, bindWaterSourceEditableCell(waterSource))
		
        case .add:
            return tableView.dequeueIdentifiableCell(indexPath, bindAddWaterSourceCell())

        default:
            fatalError("Cell not implemented")
		}
	}

	func swapDataPositions(_ sourceIndexPath: IndexPath, _ destinationIndexPath: IndexPath) {
		let sourceId: String?
		let destId: String?
		switch getItemForIndexPath(sourceIndexPath) {
		case .waterSourceItem(let waterSource):
			sourceId = waterSource.id

		default:
			return
		}
		switch getItemForIndexPath(destinationIndexPath) {
		case .waterSourceItem(let waterSource):
			destId = waterSource.id

		default:
			return
		}
		guard let sourceId = sourceId, let destId = destId else {
			return
		}
        editWaterSourceListViewModel.swapWaterSourcePositions(sourceId, destId)
	}

    func removeWaterSourceItem(_ waterSource: WaterSource) {
        editWaterSourceListViewModel.removeWaterSourceItem(waterSource)
    }

    func observeViewModel() {
        editWaterSourceListViewModel.removeItemNotifier.sink {
            self.tableView.deleteRows(at: [IndexPath(row: $0, section: 0)], with: .automatic)
        }.store(in: &cancellableBag)

        editWaterSourceListViewModel.updateListNotifier.sink { _ in
            self.tableView.reloadData()
        }.store(in: &cancellableBag)
    }

	enum Sections: CaseIterable {
		case main
	}
}
