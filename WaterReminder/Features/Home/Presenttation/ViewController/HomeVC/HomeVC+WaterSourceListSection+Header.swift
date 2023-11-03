//
//  HomeVC+Header+WaterSourceSection.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 09/08/23.
//

import UIKit
import RxFlow

extension HomeVC {
	func bindWaterSourceSectionHeader(
		_ collectionView: UICollectionView,
		_ kind: String,
		_ indexPath: IndexPath
	) -> UICollectionReusableView {
		let header = collectionView.dequeueReusableSupplementaryView(
			ofKind: kind,
			withReuseIdentifier: HomeVC.waterSourceListSectionHeader,
			for: indexPath
		)

		if let header = header as? WaterSourceListSectionHeader {
			header.clickListener = {
				self.present()
			}
		}

		return header
	}

	func present() {
		viewModel.showWaterSourceModal()
	}
}
