//
//  EditWaterSourceListVC+AddWaterSourceCell.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 03/11/23.
//

import UIKit
import WaterManagementDomain

extension EditWaterSourceListVC: CreateWaterSourceDelegate, WaterSourceDeleteDelegate {
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
}
