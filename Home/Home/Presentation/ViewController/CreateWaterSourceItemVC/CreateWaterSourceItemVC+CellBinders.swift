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
        cell.titleLabel.text = String(localized: "createWaterSource.cellTitle.waterSourceType")

        createWaterSourceItemViewModel.$waterSourceType.sink {
            cell.detailLabel.text = $0.exhibitionName
            cell.detailLabel.textColor = $0.color
        }.store(in: &cell.bag)

        cell.selectionStyle = .none
    }

    func bindWaterSourceVolumeCell(_ cell: WaterSourceTypeSettingCell) {
        createWaterSourceItemViewModel.waterWithFormat.sink {
            cell.detailLabel.text = $0.exhibitionValueWithFormat()
        }.store(in: &cell.bag)

        createWaterSourceItemViewModel.$waterSourceType.sink {
            cell.detailLabel.textColor = $0.color
        }.store(in: &cell.bag)

        cell.titleLabel.text = String(localized: "createWaterSource.cellTitle.volume")
        cell.selectionStyle = .none
    }
}
