//
//  EditWaterSourceItemVC+CellBinders.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 03/11/23.
//

import UIKit
import WaterManagementDomain

extension CreateWaterSourceItemVC {
    func bindWaterSourceTypeCell(_ cell: WaterSourceTypeSettingCell) {
        cell.titleLabel.text = String(localized: "Drink")

        createWaterSourceItemViewModel.$drink.compactMap {$0}.sinkUI {
            cell.detailLabel.text = $0.name
            cell.detailLabel.textColor = $0.color
        }.store(in: &cell.cancellableBag)

        cell.selectionStyle = .none
    }

    func bindWaterSourceVolumeCell(_ cell: WaterSourceTypeSettingCell) {
        createWaterSourceItemViewModel.waterWithFormat.sinkUI {
            cell.detailLabel.text = $0.formattedValueAndUnit
        }.store(in: &cell.cancellableBag)

        createWaterSourceItemViewModel.$drink.compactMap {$0}.sinkUI {
            cell.detailLabel.textColor = $0.color
        }.store(in: &cell.cancellableBag)

        cell.titleLabel.text = String(localized: "Volume")
        cell.selectionStyle = .none
    }
}
