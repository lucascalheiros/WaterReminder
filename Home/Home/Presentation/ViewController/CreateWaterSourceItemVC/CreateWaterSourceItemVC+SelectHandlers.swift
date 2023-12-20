//
//  EditWaterSourceItemVC+SelectHandlers.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 03/11/23.
//

import UIKit
import Core
import WaterManagementDomain

extension CreateWaterSourceItemVC: WaterSourceTypeSelector {

    func presentWaterVolumeInput(_ volume: WaterWithFormat) {
        let alert = UIAlertController(
            title: String(localized: "createWaterSource.alertTitle.waterVolume"),
            message: String(localized: "createWaterSource.alertdescription.enterWaterVolume.\(volume.volumeFormat.localizedDisplay)") ,
            preferredStyle: .alert
        )
        alert.addTextField { (textField) in
            textField.keyboardType = .decimalPad
            textField.text = volume.exhibitionValue()
            textField.textAlignment = .center
        }
        alert.addAction(UIAlertAction(title: String(localized: "generic.ok"), style: .default, handler: { [weak alert, weak self] _ in
            guard let newVolume = Float(alert?.textFields?.first?.text ?? "0") else {
                return
            }

            self?.onWaterVolumeChange(volume.volumeFormat.toMetric(newVolume))
        }))
        alert.addAction(UIAlertAction(title: String(localized: "generic.cancel"), style: .cancel))
        present(alert, animated: true, completion: nil)
    }

    func presentWaterTypeSelector(_ type: WaterSourceType) {
        let vc = SelectWaterSourceTypeVC(type, self)
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .pageSheet
        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.custom(resolver: { _ in
                200
            })]
        }
        present(nav, animated: true, completion: nil)
    }

    func onWaterVolumeChange(_ volume: Float) {
        guard volume > 0 else {
            return
        }
        createWaterSourceItemViewModel.waterInMl = Int(volume)
    }

    func onWaterSourceTypeChange(_ type: WaterSourceType) {
        createWaterSourceItemViewModel.waterSourceType = type
    }
}
