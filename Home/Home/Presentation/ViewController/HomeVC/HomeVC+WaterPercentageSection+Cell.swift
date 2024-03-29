//
//  HomeVC+Cell+WaterPercentageSection.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 09/08/23.
//

import UIKit

extension HomeVC {
	func bindPercentageView(
		_ collectionView: UICollectionView,
		_ indexPath: IndexPath
	) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: HomeVC.waterPercentageCell,
			for: indexPath
		)

		if let cell = cell as? WaterPercentageCell {
			viewModel.todayConsumedWaterPercentageByWaterType.subscribe(onNext: { percentage in
				cell.setPercentage(percentage)
			}).disposed(by: cell.disposeBag)

			viewModel.currentWaterConsumedInML.subscribe(onNext: { waterWithFormat in
				cell.setSecondaryText(text: waterWithFormat.exhibitionValue())
				cell.setFormatText(text: waterWithFormat.volumeFormat.formatDisplay)
			}).disposed(by: cell.disposeBag)

			viewModel.remainingQuantityText.subscribe(onNext: { text in
				cell.setInformativeText(text: text)
			}).disposed(by: cell.disposeBag)
		}

		return cell
	}
}
