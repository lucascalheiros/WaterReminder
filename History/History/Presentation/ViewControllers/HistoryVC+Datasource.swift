//
//  HistoryVC+Datasource.swift
//  History
//
//  Created by Lucas Calheiros on 19/12/23.
//

import WaterManagementDomain
import UIKit

extension HistoryVC {
    typealias DataSource = UICollectionViewDiffableDataSource<Sections, WaterConsumed>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Sections, WaterConsumed>

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

    override func collectionView(
        _ collectionView: UICollectionView,
        contextMenuConfigurationForItemAt indexPath: IndexPath,
        point: CGPoint
    ) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { suggestedActions in
            let deleteAction = UIAction(
                title: String(localized: "Delete"),
                image: UIImage(systemName: "trash"),
                attributes: .destructive) { _ in
                    if let waterConsumed = self.diffableDatasource.itemIdentifier(for: indexPath) {
                        self.historyViewModel.deleteWaterConsumed(waterConsumed)
                    }
            }

            return UIMenu(children: [deleteAction])
        }
    }

    enum Sections: Hashable {
        case dailyHistory(Date)
    }
}
