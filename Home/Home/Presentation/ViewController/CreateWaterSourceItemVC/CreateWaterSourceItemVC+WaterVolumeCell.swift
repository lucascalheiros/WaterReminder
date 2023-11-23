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
            cell.detailLabel.text = waterWithFormat.exhibitionValueWithFormat()
            cell.detailLabel.textColor = AppColorGroup.primary.color
        }
        cell.selectionStyle = .none
        return cell
    }

    func onWaterVolumeChange(_ volume: Float) {
        guard let index = EditWaterSourceItemOptions.allCases.firstIndex(of: .waterVolume), volume > 0 else {
            return
        }
        let volumeFormat = waterWithFormat.volumeFormat
        self.waterWithFormat = WaterWithFormat(waterInML: Int(volumeFormat.toMetric(volume)), volumeFormat: volumeFormat)
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
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
