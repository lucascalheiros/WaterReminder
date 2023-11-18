//
//  EditWaterSourceListVC+AddWaterSourceCell.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 03/11/23.
//

import UIKit

extension EditWaterSourceListVC: CreateWaterSourceDelegate {

    func getAddWaterSourceCell(_ indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(
            withIdentifier: AddWaterSourceCell.identifier,
            for: indexPath
        )
    }

    func presentAddWaterSource() {
        let vc = CreateWaterSourceItemVC()
        vc.createWaterSourceDelegate = self
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .pageSheet
        nav.setDefaultAppearance()

        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.large()]
        }

        present(nav, animated: true, completion: nil)
    }

    func onCreateWaterSource(_ volume: Int, _ type: WaterSourceType) {
        manageWaterSourceUseCase.createWaterSource(waterVolume: volume, waterSourceType: type)
            .subscribe(onCompleted: { [weak self] in
                self?.loadTableData()
            }).disposed(by: disposeBag)
    }

}
