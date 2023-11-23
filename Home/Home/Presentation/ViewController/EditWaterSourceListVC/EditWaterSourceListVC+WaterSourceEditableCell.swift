//
//  EditWaterSourceListVC+WaterSourceEditableCell.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 03/11/23.
//

import UIKit
import WaterManagementDomain

extension EditWaterSourceListVC: WaterSourceDeleteDelegate {
    
    func onDeleteWaterSource(_ waterSource: WaterSource) {
        manageWaterSourceUseCase.deleteWaterSource(waterSource: waterSource)
            .do(onError: { error in
                print(error)
            })
            .subscribe(onCompleted: { [weak self] in
                self?.removeWaterSourceItem(waterSource)
            })
            .disposed(by: disposeBag)
    }

    func getWaterSourceEditableCell(_ indexPath: IndexPath, _ waterSource: WaterSource) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: WaterSourceEditableCell.identifier,
            for: indexPath
        )
        if let cell = cell as? WaterSourceEditableCell {
            cell.bindData(waterSource: waterSource, volumeFormat: volumeFormat)
            cell.waterSourceDeleteDelegate = self
        }
        return cell
    }

}
