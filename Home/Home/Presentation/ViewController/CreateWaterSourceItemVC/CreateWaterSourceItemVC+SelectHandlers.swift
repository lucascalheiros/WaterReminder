//
//  EditWaterSourceItemVC+SelectHandlers.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 03/11/23.
//

import UIKit
import Core
import WaterManagementDomain

extension CreateWaterSourceItemVC {

    func presentWaterVolumeInput(_ volume: Volume) {
        let alert = UIAlertController(
            title: String(localized: "createWaterSource.alertTitle.waterVolume"),
            message: String(localized: "createWaterSource.alertdescription.enterWaterVolume.\(volume.unit.formatted)") ,
            preferredStyle: .alert
        )
        alert.addTextField { (textField) in
            textField.keyboardType = .decimalPad
            textField.text = volume.formattedValue
            textField.textAlignment = .center
        }
        alert.addAction(UIAlertAction(title: String(localized: "generic.ok"), style: .default, handler: { [weak alert, weak self] _ in
            guard let newVolume = Double(alert?.textFields?.first?.text ?? "0") else {
                return
            }
            let volume = Volume(newVolume, volume.unit).to(.milliliters).value
            guard volume > 0 else {
                return
            }
            self?.createWaterSourceItemViewModel.waterInMl = Int(volume)
        }))
        alert.addAction(UIAlertAction(title: String(localized: "generic.cancel"), style: .cancel))
        present(alert, animated: true, completion: nil)
    }

    func presentWaterTypeSelector(_ drink: Drink, _ drinks: [Drink]) {
        let vc = SelectWaterSourceTypeVC(drink, drinks)
        vc.onDrinkSelected = { [weak self] in
            self?.createWaterSourceItemViewModel.drink = $0
        }
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .pageSheet
        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.custom(resolver: { _ in
                200
            })]
        }
        present(nav, animated: true, completion: nil)
    }

}
