//
//  HomeViewController+Datasource.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 15/08/23.
//

import UIKit

extension HomeViewController: UICollectionViewDataSource {
	static let waterPercentageHeaderView = "WaterPercentageHeaderView"
	static let waterSourceListHorizontalCollectionView = "WaterSourceListHorizontalCollectionView"

	func registerCells(_ collectionView: UICollectionView) {
		collectionView.register(
			WaterPercentageHeaderView.self,
			forCellWithReuseIdentifier: waterPercentageHeaderView
		)
		collectionView.register(
			WaterSourceListHorizontalCollectionView.self,
			forCellWithReuseIdentifier: waterSourceListHorizontalCollectionView
		)
	}

	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return sections.count
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return sections[section].itemsForSection()
	}

	func collectionView(
		_ collectionView: UICollectionView,
		cellForItemAt indexPath: IndexPath
	) -> UICollectionViewCell {
		switch sections[indexPath.section] {
		case .mainWaterTracker:
			return bindPercentageView(collectionView, indexPath)
		case .waterSourceList:
			return bindWaterSourceListCellBind(collectionView, indexPath)
		}
	}
}
