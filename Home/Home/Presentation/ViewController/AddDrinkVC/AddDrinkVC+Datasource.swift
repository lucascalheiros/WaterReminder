//
//  EditWaterSourceItemVC+Datasource.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 21/10/23.
//

import UIKit

extension AddDrinkVC {
    func registerCells() {
        tableView.registerIdentifiableCell(WaterSourceTypeSettingCell.self)
        tableView.registerIdentifiableCell(WaterSourceTypeSettingStepperCell.self)
        tableView.registerIdentifiableCell(WaterSourceSettingColorCell.self)
    }

	override func tableView(_ tableView: UITableView, numberOfRowsInSection sectionIndex: Int) -> Int {
		switch Sections.allCases[safe: sectionIndex] {
		case .main:
            return Options.allCases.count
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
        case .name:
            return tableView.dequeueIdentifiableCell(indexPath, bindNameCell)
        case .hydration:
            return tableView.dequeueIdentifiableCell(indexPath, bindHydrationCell)
        case .lightColor:
            return tableView.dequeueIdentifiableCell(indexPath, bindLightColorCell)
        case .darkColor:
            return tableView.dequeueIdentifiableCell(indexPath, bindDarkColorCell)
        default:
            fatalError("UITableCell not implemented")
        }
	}

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch getItem(indexPath) {
        case .name:
            presentNamePicker()
        case .lightColor:
            presentColorPicker(forDark: false)
        case .darkColor:
            presentColorPicker(forDark: true)
        default:
            break
        }
    }

    private func getItem(_ indexPath: IndexPath) -> SectionOption? {
        switch Sections.allCases[safe: indexPath.section] {
        case .main:
            return Options.allCases[indexPath.row]
        default:
            return nil
        }
    }

    private typealias SectionOption = Options

	private enum Options: CaseIterable {
        case name
        case hydration
        case lightColor
		case darkColor
	}

	private enum Sections: CaseIterable {
		case main
	}

}
