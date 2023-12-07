//
//  EditWaterSourceListVC+CellBinders.swift
//  Home
//
//  Created by Lucas Calheiros on 25/11/23.
//

import Common
import WaterManagementDomain

extension EditWaterSourceListVC {
    func bindAddWaterSourceCell() -> (AddWaterSourceCell) -> Void {
        return { _ in }
    }
    
    func bindWaterSourceEditableCell(_ waterSource: WaterSource) -> ((WaterSourceEditableCell) -> Void) {
        return { cell in
            cell.bindData(waterSource: waterSource, volumeFormat: self.volumeFormat)
            cell.waterSourceDeleteDelegate = self
        }
    }
}
