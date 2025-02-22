//
//  ViewController.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 07/05/23.
//

import UIKit
import WaterManagementDomain
import Combine
import Common

class WaterSourceListHorizontalCollectionView: ProgrammaticView, UICollectionViewDelegate {

    var onItemClick: ((WaterSource) -> Void)?

    var onAddClick: (() -> Void)?

    var onDeleteClick: ((WaterSource) -> Void)?

    var onEditClick: (() -> Void)?

    @Published var volumeFormat: SystemFormat = SystemFormat.metric

    private var cancellableBag = Set<AnyCancellable>()

    private lazy var waterContainerTableView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let widthPerItem = (frame.width - 40) / 2
        layout.itemSize = CGSize(width: widthPerItem, height: 100)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets.horizontal(inset: 16)
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.registerIdentifiableCell(WaterSourceCellView.self)
        collectionView.registerIdentifiableCell(AddCupCell.self)
        return collectionView
    }()

    private lazy var dataSource: DataSource = makeDatasource()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addConstrainedSubviews(waterContainerTableView)

        waterContainerTableView.dataSource = dataSource

        NSLayoutConstraint.activate([
            waterContainerTableView.topAnchor.constraint(equalTo: topAnchor),
            waterContainerTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            waterContainerTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            waterContainerTableView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func applySnapshot(_ items: [CupInfo], animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(items.map { .item($0) } + [.add])
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }

    private func makeDatasource() -> DataSource {
        let dataSource = DataSource(
            collectionView: self.waterContainerTableView,
            cellProvider: { (collectionView, indexPath, cupCard) ->
                UICollectionViewCell? in
                switch cupCard {
                case .item(let waterSource):
                    return collectionView.dequeueIdentifiableCell(indexPath) { (cell: WaterSourceCellView) in
                        self.$volumeFormat
                            .map { Optional($0) }
                            .assign(to: \.volumeFormat, on: cell)
                            .store(in: &cell.cancellableBag)

                        cell.waterSource = waterSource

                        cell.addTapListener {
                            self.onItemClick?(waterSource.cup)
                        }
                    }
                case .add:
                    return collectionView.dequeueIdentifiableCell(indexPath) { (cell: AddCupCell) in
                        cell.addTapListener {
                            self.onAddClick?()
                        }
                    }
                }
            })
        return dataSource
    }


    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        snapScroll(scrollView)
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            snapScroll(scrollView)
        }
    }

    func snapScroll(_ scrollView: UIScrollView) {
        let currentX = scrollView.contentOffset.x
        let widthPerItem = (frame.width - 32) / 2
        let firstVisibleItem = ((currentX - 16) / widthPerItem).rounded()
        let targetX = firstVisibleItem * widthPerItem + 4 * firstVisibleItem
        waterContainerTableView.scrollRectToVisible(CGRect(x: max(targetX, 0), y: 0, width: frame.width, height: 1), animated: true)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        contextMenuConfigurationForItemAt indexPath: IndexPath,
        point: CGPoint
    ) -> UIContextMenuConfiguration? {
        guard let item = dataSource.itemIdentifier(for: indexPath), case let .item(waterSource) = item else {
            return nil
        }

        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { suggestedActions in
            let moveAction = UIAction(
                title: String(localized: "Edit"),
                image: UIImage(systemName: "pencil")
            ) { _ in
                self.onEditClick?()
            }

            let deleteAction = UIAction(
                title: String(localized: "Delete"),
                image: UIImage(systemName: "trash"),
                attributes: .destructive
            ) { _ in
                self.onDeleteClick?(waterSource.cup)
            }

            return UIMenu(children: [moveAction, deleteAction])
        }
    }

    private typealias DataSource = UICollectionViewDiffableDataSource<WaterSourceSection, CupCard>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<WaterSourceSection, CupCard>

    private enum WaterSourceSection {
        case main
    }

    enum CupCard: Hashable {
        case item(CupInfo)
        case add
    }
}
