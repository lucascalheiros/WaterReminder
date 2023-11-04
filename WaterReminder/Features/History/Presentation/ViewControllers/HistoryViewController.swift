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
    typealias DataSource = UICollectionViewDiffableDataSource<Sections, WaterConsumed>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Sections, WaterConsumed>

	let disposeBag = DisposeBag()
	let historyViewModel: HistoryViewModel

    lazy var diffableDatasource: DataSource  = makeDatasource()

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

        prepareConfiguration()
        loadData()
	}

    func loadData() {
        historyViewModel.waterConsumedByDay.subscribe(onNext: {
            self.applySnapshot(waterConsumedByDay: $0, animatingDifferences: true)
        }).disposed(by: disposeBag)
    }

    func prepareConfiguration() {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.backgroundColor = .systemTeal
        configuration.showsSeparators = true
        configuration.separatorConfiguration.bottomSeparatorInsets = NSDirectionalEdgeInsets()
        configuration.headerMode = .supplementary

        // TODO Default height for section is 17.6667, so there is a warning for constraint satisfaction
        //    inside TodayConsumptionSection as ios (awfully) does not provide a way to set the section
        //    height using UICollectionLayoutListConfiguration, fix in the future, lowest priority since its
        //    functioning correctly
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout.list(using: configuration)
        view.backgroundColor = .systemTeal
        collectionView.backgroundColor = .systemTeal

        // Set the data source and delegate
        collectionView.dataSource = diffableDatasource
        collectionView.delegate = self

        registerCells()
        configureHeader()
    }

    func registerCells() {
        collectionView.register(
            DailyConsumptionCell.self,
            forCellWithReuseIdentifier: DailyConsumptionCell.identifier
        )
        collectionView.register(
            DailyConsumptionSection.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: DailyConsumptionSection.identifier
        )
    }

    func applySnapshot(waterConsumedByDay: [Date:[WaterConsumed]], animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections(waterConsumedByDay.keys.sorted(by: >).map(Sections.dailyHistory))
        waterConsumedByDay.forEach { day, waterConsumedList in
            snapshot.appendItems(waterConsumedList, toSection: .dailyHistory(day))
        }
        diffableDatasource.apply(snapshot, animatingDifferences: animatingDifferences)
    }

    func configureHeader() {
        diffableDatasource.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            if let sectionHeader = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: DailyConsumptionSection.identifier,
                for: indexPath
            ) as? DailyConsumptionSection {
                guard let section = self.diffableDatasource.sectionIdentifier(for: indexPath.section) else {
                    return sectionHeader
                }
                switch section {
                case .dailyHistory(let date):
                    sectionHeader.bindData(
                        date: date,
                        percentageWithWaterSourceTypeList: self.historyViewModel.waterPercentageWithTypeByDay(date),
                        consumedVolume: self.historyViewModel.waterConsumedByDay(date)
                    )
                }

                return sectionHeader
            }
            return UICollectionReusableView()
        }
    }

    func makeDatasource() -> DataSource {
        let dataSource = DataSource(
            collectionView: self.collectionView,
            cellProvider: { (collectionView, indexPath, waterSource) ->
                UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: DailyConsumptionCell.identifier,
                    for: indexPath
                )
                if let cell = cell as? DailyConsumptionCell {
                    cell.waterConsumed.accept(waterSource)
                    self.historyViewModel.volumeFormat.bind(to: cell.volumeFormat).disposed(by: self.disposeBag)
                }
                return cell
            })
        return dataSource
    }

    enum Sections: Hashable {
        case dailyHistory(Date)
    }
}
