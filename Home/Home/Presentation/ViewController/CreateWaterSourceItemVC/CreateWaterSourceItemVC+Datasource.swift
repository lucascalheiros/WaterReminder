//
//  EditWaterSourceItemVC+Datasource.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 21/10/23.
//

import UIKit

extension CreateWaterSourceItemVC {
    func registerCells() {
        tableView.registerIdentifiableCell(WaterSourceTypeSettingCell.self)
    }

	override func tableView(_ tableView: UITableView, numberOfRowsInSection sectionIndex: Int) -> Int {
		switch Sections.allCases[safe: sectionIndex] {
		case .main:
            return EditWaterSourceItemOptions.allCases.count
		default:
			return 0
		}
	}

	override func numberOfSections(in tableView: UITableView) -> Int {
		Sections.allCases.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = getItem(indexPath)
        switch item {
        case .waterVolume:
            return tableView.dequeueIdentifiableCell(indexPath, bindWaterSourceVolumeCell) 
        case .waterSourceType:
            return tableView.dequeueIdentifiableCell(indexPath, bindWaterSourceTypeCell)
        default:
            fatalError("UITableCell not implemented")
        }
	}

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch getItem(indexPath) {
        case .waterSourceType:
            guard let drink = createWaterSourceItemViewModel.drink else {
                return
            }
            presentWaterTypeSelector(drink, createWaterSourceItemViewModel.drinks)
        case .waterVolume:
            presentWaterVolumeInput(createWaterSourceItemViewModel.getCurrentWaterWithFormat())
        case .none:
            break
        }
    }

    private func getItem(_ indexPath: IndexPath) -> SectionOption? {
        switch Sections.allCases[safe: indexPath.section] {
        case .main:
            return EditWaterSourceItemOptions.allCases[indexPath.row]
        default:
            return nil
        }
    }

    private typealias SectionOption = EditWaterSourceItemOptions

	private enum EditWaterSourceItemOptions: CaseIterable {
        case waterVolume
		case waterSourceType
	}

	private enum Sections: CaseIterable {
		case main
	}

}
