//
//  EditWaterSourceItemVC+CellBinders.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 03/11/23.
//

import UIKit
import WaterManagementDomain
import Components

extension AddDrinkVC {
    func bindNameCell(_ cell: WaterSourceTypeSettingCell) {
        cell.titleLabel.text = String(localized: "Name")
        cell.selectionStyle = .none

        addDrinkViewModel.$name.sinkUI {
            cell.detailLabel.text = $0
        }.store(in: &cell.cancellableBag)
    }

    func bindHydrationCell(_ cell: WaterSourceTypeSettingStepperCell) {
        cell.titleLabel.text = String(localized: "Hydration")
        cell.selectionStyle = .none
        cell.onValueChange = { [weak self] newValue in
            self?.addDrinkViewModel.setHydration(newValue)
        }

        addDrinkViewModel.$hydration.sinkUI {
            cell.value = $0
        }.store(in: &cell.cancellableBag)
    }

    func bindLightColorCell(_ cell: WaterSourceSettingColorCell) {
        cell.titleLabel.text = String(localized: "On Light Color")
        cell.selectionStyle = .none
        cell.strokeColor = DefaultComponentsTheme.current.surface.color.resolvedColor(with: UITraitCollection(userInterfaceStyle: .light))

        addDrinkViewModel.$lightColor.sinkUI {
            cell.color = $0
        }.store(in: &cell.cancellableBag)
    }

    func bindDarkColorCell(_ cell: WaterSourceSettingColorCell) {
        cell.titleLabel.text = String(localized: "On Dark Color")
        cell.selectionStyle = .none
        cell.strokeColor = DefaultComponentsTheme.current.surface.color.resolvedColor(with: UITraitCollection(userInterfaceStyle: .dark))

        addDrinkViewModel.$darkColor.sinkUI {
            cell.color = $0
        }.store(in: &cell.cancellableBag)
    }
}
