//
//  EditWaterSourceItemVC+WaterVolumeCell.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 03/11/23.
//

import UIKit
import Core
import WaterManagementDomain

extension CreateWaterSourceItemVC {

    func getWaterSourceVolumeCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: WaterSourceTypeSettingCell.identifier,
            for: indexPath
        )
        if let cell = cell as? WaterSourceTypeSettingCell {
            cell.titleLabel.text = String(localized: "createWaterSource.cellTitle.volume")

            waterWithFormat.subscribe {
                cell.detailLabel.text = $0.exhibitionValueWithFormat()
            }.disposed(by: cell.disposeBag)

            waterSourceType.subscribe {
                cell.detailLabel.textColor = $0.color
            }.disposed(by: cell.disposeBag)

        }
        cell.selectionStyle = .none
        return cell
    }

    func onWaterVolumeChange(_ volume: Float) {
        guard let index = EditWaterSourceItemOptions.allCases.firstIndex(of: .waterVolume), volume > 0 else {
            return
        }
        let volumeFormat = waterWithFormat.value.volumeFormat
        self.waterWithFormat.accept(WaterWithFormat(waterInML: Int(volumeFormat.toMetric(volume)), volumeFormat: volumeFormat))
    }

    func presentWaterVolumeInput(_ volume: WaterWithFormat) {
        let alert = UIAlertController(title: String(localized: "createWaterSource.alertTitle.waterVolume"), message: String(localized: "createWaterSource.alertdescription.enterWaterVolume.\(volume.volumeFormat.localizedDisplay)") , preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.keyboardType = .decimalPad
            textField.text = volume.exhibitionValue()
            textField.textAlignment = .center
        }
        alert.addAction(UIAlertAction(title: String(localized: "generic.ok"), style: .default, handler: { [weak alert, weak self] _ in
            guard let volume = Float(alert?.textFields?.first?.text ?? "0") else {
                return
            }
            self?.onWaterVolumeChange(volume)
        }))
        alert.addAction(UIAlertAction(title: String(localized: "generic.cancel"), style: .cancel))
        present(alert, animated: true, completion: nil)
    }

}
