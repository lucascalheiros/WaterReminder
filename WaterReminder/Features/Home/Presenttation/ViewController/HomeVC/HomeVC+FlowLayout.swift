//
//  HomeVC+FlowLayout.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 15/08/23.
//

import UIKit

extension HomeVC: UICollectionViewDelegateFlowLayout {
	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		sizeForItemAt indexPath: IndexPath
	) -> CGSize {
		switch sections[indexPath.section] {
		case .mainWaterTracker:
			let horizontalPadding = insetBySection(section: indexPath.section).horizontalPadding()
			return CGSize(width: collectionView.bounds.width - horizontalPadding, height: 300)
		case .waterSourceList:
			return CGSize(width: collectionView.bounds.width, height: 248)
		}
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		switch sections[section] {
		case .mainWaterTracker:
			return CGSize.zero
		case .waterSourceList:
			return CGSize(width: collectionView.bounds.width, height: 32)
		}
	}

	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		minimumLineSpacingForSectionAt section: Int
	) -> CGFloat {
		return 16
	}

	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		insetForSectionAt section: Int
	) -> UIEdgeInsets {
		insetBySection(section: section)
	}

	private func insetBySection(section: Int) -> UIEdgeInsets {
		switch sections[section] {
		case .mainWaterTracker:
			return UIEdgeInsets.vertical(inset: 8).horizontal(inset: 16)
		case .waterSourceList:
			return UIEdgeInsets.set(inset: 0)
		}
	}
}
