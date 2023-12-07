//
//  EditWaterSourceItemVC+Datasource.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 21/10/23.
//

import UIKit

extension CreateWaterSourceItemVC {

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
            return getWaterSourceVolumeCell(indexPath)
        case .waterSourceType:
            return getWaterSourceTypeCell(indexPath)
        default:
            return UITableViewCell()
        }
	}

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch getItem(indexPath) {
        case .waterSourceType:
            presentWaterTypeSelector(waterSourceType.value)
        case .waterVolume:
            presentWaterVolumeInput(waterWithFormat.value)
        case .none:
            break
        }
    }

	func registerCells() {
		tableView.register(
			WaterSourceTypeSettingCell.self,
			forCellReuseIdentifier: WaterSourceTypeSettingCell.identifier
		)
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

	enum EditWaterSourceItemOptions: CaseIterable {
		case waterSourceType
		case waterVolume
	}

	private enum Sections: CaseIterable {
		case main
	}

}
