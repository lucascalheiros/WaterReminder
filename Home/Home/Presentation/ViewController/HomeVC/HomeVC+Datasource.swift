//
//  HomeVC+Datasource.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 15/08/23.
//

import UIKit

extension HomeVC: UICollectionViewDataSource {
	static let waterPercentageCell = "WaterPercentageCell"
	static let waterSourceListHorizontalCollectionView = "WaterSourceListHorizontalCollectionView"
	static let waterSourceListSectionHeader = "WaterSourceListSectionHeader"

	func registerCells(_ collectionView: UICollectionView) {
		collectionView.register(
			WaterPercentageCell.self,
			forCellWithReuseIdentifier: HomeVC.waterPercentageCell
		)
		collectionView.register(
			WaterSourceListHorizontalCollectionView.self,
			forCellWithReuseIdentifier: HomeVC.waterSourceListHorizontalCollectionView
		)
		collectionView.register(
			WaterSourceListSectionHeader.self,
			forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
			withReuseIdentifier: HomeVC.waterSourceListSectionHeader
		)
	}

	func collectionView(
		_ collectionView: UICollectionView,
		viewForSupplementaryElementOfKind kind: String,
		at indexPath: IndexPath
	) -> UICollectionReusableView {
		switch sections[indexPath.section] {
		case .waterSourceList:
			return bindWaterSourceSectionHeader(collectionView, kind, indexPath)
		default:
			return UICollectionReusableView()
		}
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
