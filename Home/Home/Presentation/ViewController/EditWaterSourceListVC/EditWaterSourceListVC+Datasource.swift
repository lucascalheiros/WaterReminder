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
			return self.waterSourceList.count

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
            presentAddWaterSource()

        default:
            break
        }
    }

	func getItemForIndexPath(_ indexPath: IndexPath) -> WaterSourceSectionItems? {
		switch Sections.allCases[safe: indexPath.section] {
		case .main:
			return self.waterSourceList[safe: indexPath.row]

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
		self.reorderWaterSourceUseCase.reorderWaterSources(sourceId: sourceId, destinationId: destId).subscribe().disposed(by: disposeBag)
	}

    func removeWaterSourceItem(_ waterSource: WaterSource) {
        guard let index = self.waterSourceList.firstIndex(where: {
            switch $0 {
            case .waterSourceItem(let item):
                return item.id == waterSource.id

            default:
                return false
            }
        }) else {
            loadTableData()
            return
        }
        self.waterSourceList.remove(at: index)
        self.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        self.loadTableData(reloadTable: false)
    }

    func loadTableData(reloadTable: Bool = true) {
		waterSourceListObservable.safeAsSingle().subscribe(onSuccess: {
            self.waterSourceList = $0.waterSourceList.map({ .waterSourceItem($0) }) + [.add]
            self.volumeFormat = $0.volumeFormat
            if reloadTable {
                self.tableView.reloadData()
            }
		}).disposed(by: disposeBag)
	}

	enum Sections: CaseIterable {
		case main
	}

	enum WaterSourceSectionItems {
		case waterSourceItem(WaterSource)
		case add
	}
}
