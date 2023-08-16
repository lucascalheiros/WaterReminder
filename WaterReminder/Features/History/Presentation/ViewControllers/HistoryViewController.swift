//
//  HistoryViewController.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 14/05/23.
//

import UIKit
import RxSwift
import RxCocoa

class HistoryViewController: UICollectionViewController {
	let disposeBag = DisposeBag()
	let historyViewModel: HistoryViewModel
	let todayConsumptionSection = "TodayConsumptionSection"
	let todayConsumptionCell = "TodayConsumptionCell"

	var todayWaterConsumedList: [WaterConsumed] = []

	init(historyViewModel: HistoryViewModel) {
		self.historyViewModel = historyViewModel
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		super.init(collectionViewLayout: layout)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
		configuration.backgroundColor = .systemTeal
		configuration.showsSeparators = true
		configuration.separatorConfiguration.bottomSeparatorInsets = NSDirectionalEdgeInsets()
		configuration.headerMode = .supplementary
		// TODO Default height for section is 17.6667, so there is a warning for constraint satisfaction
		//	inside TodayConsumptionSection as ios (awfully) does not provide a way to set the section
		//	height using UICollectionLayoutListConfiguration, fix in the future, lowest priority since its
		//	functioning correctly
		collectionView.collectionViewLayout = UICollectionViewCompositionalLayout.list(using: configuration)
		view.backgroundColor = .systemTeal
		collectionView.backgroundColor = .systemTeal

		// Register cell classes and other setup
		collectionView.register(
			TodayConsumptionCell.self,
			forCellWithReuseIdentifier: todayConsumptionCell
		)
		collectionView.register(
			TodayConsumptionSection.self,
			forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
			withReuseIdentifier: todayConsumptionSection
		)

		historyViewModel.todayWaterConsumedList.subscribe(onNext: {
			self.todayWaterConsumedList = $0.reversed()
			self.collectionView.reloadSections(IndexSet(integer: 0))
		}).disposed(by: disposeBag)

		// Set the data source and delegate
		collectionView.dataSource = self
		collectionView.delegate = self
	}

	override func numberOfSections(in collectionView: UICollectionView) -> Int {
		1
	}

	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		switch section {
		case 0:
			return todayWaterConsumedList.count
		default:
			return 0
		}
	}

	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		switch indexPath.section {
		case 0:
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: todayConsumptionCell, for: indexPath)
			if let waterConsumedCell = cell as? TodayConsumptionCell {
				waterConsumedCell.waterConsumed.accept(todayWaterConsumedList[indexPath.row])
				historyViewModel.volumeFormat.bind(to: waterConsumedCell.volumeFormat).disposed(by: disposeBag)
			}
			return cell
		default:
			break
		}

		return UICollectionViewCell()
	}

	override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		switch indexPath.section {
		case 0:
			if let sectionHeader = collectionView.dequeueReusableSupplementaryView(
				ofKind: kind,
				withReuseIdentifier: todayConsumptionSection,
				for: indexPath
			) as? TodayConsumptionSection {
				historyViewModel.todayConsumedWaterPercentage
					.bind(to: sectionHeader.todayConsumedWaterPercentage).disposed(by: disposeBag)
				historyViewModel.todayConsumedVolume
					.bind(to: sectionHeader.todayConsumedVolume).disposed(by: disposeBag)
				return sectionHeader
			}
		default:
			break
		}
		return UICollectionReusableView()
	}
}
