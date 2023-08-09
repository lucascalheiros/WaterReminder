//
//  HomeViewController+PercentageViewBind.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 09/08/23.
//

import UIKit

extension HomeViewController {
	func bindPercentageView(
		_ collectionView: UICollectionView,
		_ indexPath: IndexPath
	) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: waterPercentageHeaderView,
			for: indexPath
		)

		if let cell = cell as? WaterPercentageHeaderView {
			viewModel.consumedPercentage.subscribe(onNext: { percentage in
				cell.setPercentage(percentage: percentage)
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
