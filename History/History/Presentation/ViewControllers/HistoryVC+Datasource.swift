//
//  HistoryVC+Datasource.swift
//  History
//
//  Created by Lucas Calheiros on 19/12/23.
//

import WaterManagementDomain
import UIKit
import Combine

extension HistoryVC {
    typealias DataSource = UICollectionViewDiffableDataSource<Sections, SectionItems>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Sections, SectionItems>

    func registerCells() {
        collectionView.registerIdentifiableCell(DailyConsumptionCell.self)
        collectionView.registerIdentifiableCell(WaterConsumptionChartCell.self)
        collectionView.register(
            DailyConsumptionSection.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: DailyConsumptionSection.identifier
        )
        collectionView.register(
            EmptyHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: EmptyHeader.identifier
        )
    }

    func applySnapshot(waterConsumedByDay: [Date:[WaterConsumed]], animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.historyChart] + waterConsumedByDay.keys.sorted(by: >).map(Sections.dailyHistory))
        snapshot.appendItems([.historyChart(waterConsumedByDay.reduce([], {$0 + $1.value}))], toSection: .historyChart)
        waterConsumedByDay.forEach { day, waterConsumedList in
            snapshot.appendItems(waterConsumedList.map {.waterConsumed($0)}, toSection: .dailyHistory(day))
        }
        diffableDatasource.apply(snapshot, animatingDifferences: animatingDifferences)
    }

    func configureHeader() {
        diffableDatasource.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            guard let section = self.diffableDatasource.sectionIdentifier(for: indexPath.section) else {
                return nil
            }

            switch section {
            case .dailyHistory(let date):
                if let sectionHeader = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: DailyConsumptionSection.identifier,
                    for: indexPath
                ) as? DailyConsumptionSection {
                    sectionHeader.bindData(
                        date: date,
                        percentageWithWaterSourceTypeList: self.historyViewModel.waterPercentageWithTypeByDay(date),
                        consumedVolume: self.historyViewModel.waterConsumedByDay(date)
                    )

                    return sectionHeader
                }
            default:
                return collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: EmptyHeader.identifier,
                    for: indexPath
                )
            }

            return nil
        }
    }

    func makeDatasource() -> DataSource {
        let dataSource = DataSource(
            collectionView: self.collectionView,
            cellProvider: { (collectionView, indexPath, item) ->
                UICollectionViewCell? in
                switch item {
                case .historyChart(let waterConsumedList):
                    return collectionView.dequeueIdentifiableCell(indexPath) { (cell: WaterConsumptionChartCell) in
                        cell.bind(in: self, viewModel: self.historyViewModel.historyChartModel)
                    }
                case .waterConsumed(let waterConsumed):
                    return collectionView.dequeueIdentifiableCell(indexPath) { (cell: DailyConsumptionCell) in
                        cell.bind(waterConsumed: Just(waterConsumed).eraseToAnyPublisher(), volumeFormat: self.historyViewModel.$volumeFormat.eraseToAnyPublisher())
                    }
                }
            })
        return dataSource
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        contextMenuConfigurationForItemAt indexPath: IndexPath,
        point: CGPoint
    ) -> UIContextMenuConfiguration? {
        guard case .dailyHistory = diffableDatasource.sectionIdentifier(for: indexPath.section) else {
            return nil
        }

        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { suggestedActions in
            let deleteAction = UIAction(
                title: String(localized: "Delete"),
                image: UIImage(systemName: "trash"),
                attributes: .destructive) { _ in
                    if case .waterConsumed(let waterConsumed) =  self.diffableDatasource.itemIdentifier(for: indexPath) {
                        self.historyViewModel.deleteWaterConsumed(waterConsumed)
                    }
            }

            return UIMenu(children: [deleteAction])
        }
    }

    enum SectionItems: Hashable {
        case historyChart([WaterConsumed])
        case waterConsumed(WaterConsumed)
    }

    enum Sections: Hashable {
        case historyChart
        case dailyHistory(Date)
    }
}
