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
    
    func bindWaterSourceEditableCell(_ cupInfo: CupInfo) -> ((WaterSourceEditableCell) -> Void) {
        return { cell in
            cell.waterSource = cupInfo
            self.editWaterSourceListViewModel.volumeFormat
                .map { Optional($0) }
                .assign(to: \.volumeFormat, on: cell)
                .store(in: &cell.cancellableBag)
            cell.onDeleteWaterSource = self.editWaterSourceListViewModel.onDeleteWaterSource
        }
    }
}
