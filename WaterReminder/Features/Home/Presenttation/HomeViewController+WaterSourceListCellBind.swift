//
//  HomeViewController+WaterSourceListCellBind.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 09/08/23.
//

import UIKit

extension HomeViewController {
	func bindWaterSourceListCellBind(
		_ collectionView: UICollectionView,
		_ indexPath: IndexPath
	) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: waterSourceListHorizontalCollectionView,
			for: indexPath
		)

		if let cell = cell as? WaterSourceListHorizontalCollectionView {
			viewModel.waterSourceList.subscribe(onNext: {
				cell.applySnapshot(waterContainerList: $0)
			}).disposed(by: cell.disposeBag)

			viewModel.volumeFormat.bind(to: cell.volumeFormatBehaviorRelay)
				.disposed(by: cell.disposeBag)

			cell.waterSourceListener = WaterSourceListener(
				itemClickListener: { [weak self] in
					self?.viewModel?.addWaterVolume(waterSource: $0)
				},
				pinClickListener: { [weak self] in
					self?.viewModel?.updateWaterSourcePinState(waterSource: $0)
				}
			)
		}

		return cell
	}
}
