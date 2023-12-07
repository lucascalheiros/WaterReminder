//
//  EditWaterSourceItemVC+WaterSourceTypeCell.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 03/11/23.
//

import UIKit
import WaterManagementDomain

extension CreateWaterSourceItemVC: WaterSourceTypeSelector {

    func getWaterSourceTypeCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: WaterSourceTypeSettingCell.identifier,
            for: indexPath
        )
        if let cell = cell as? WaterSourceTypeSettingCell {
            cell.titleLabel.text = String(localized: "createWaterSource.cellTitle.waterSourceType")

            waterSourceType.subscribe {
                cell.detailLabel.text = $0.exhibitionName
                cell.detailLabel.textColor = $0.color
            }.disposed(by: cell.disposeBag)

        }
        cell.selectionStyle = .none
        return cell
    }

    func onWaterSourceTypeChange(_ type: WaterSourceType) {
        guard let index = EditWaterSourceItemOptions.allCases.firstIndex(of: .waterSourceType) else {
            return
        }
        waterSourceType.accept(type)
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
}
