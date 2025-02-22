//
//  DrinkListHorizontalCollectionView.swift
//  Home
//
//  Created by Lucas Calheiros on 08/02/25.
//

import Common
import UIKit
import WaterManagementDomain
import Combine

class DrinkListHorizontalCollectionView: ProgrammaticView, UICollectionViewDelegate {
    static var identifier: String = "DrinkListHorizontalCollectionView"

    var cancellableBag = Set<AnyCancellable>()

    var onItemClick: ((Drink) -> Void)?

    var onAddClick: (() -> Void)?

    var onEditClick: (() -> Void)?

    var onDeleteClick: ((Drink) -> Void)?

    private lazy var dataSource: DataSource = makeDatasource()

    private lazy var drinkListView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets.horizontal(inset: 16)
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.registerIdentifiableCell(DrinkCell.self)
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addConstrainedSubviews(drinkListView)

        drinkListView.dataSource = dataSource

        NSLayoutConstraint.activate([
            drinkListView.topAnchor.constraint(equalTo: topAnchor),
            drinkListView.bottomAnchor.constraint(equalTo: bottomAnchor),
            drinkListView.trailingAnchor.constraint(equalTo: trailingAnchor),
            drinkListView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }

    func applySnapshot(drinks: [Drink], animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(drinks.map { .item($0) } + [.add])
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }

    private func makeDatasource() -> DataSource {
        let dataSource = DataSource(
            collectionView: self.drinkListView,
            cellProvider: { (collectionView, indexPath, card) -> UICollectionViewCell? in

                switch card {
                case .item(let drink):
                    collectionView.dequeueIdentifiableCell(indexPath) { (cell: DrinkCell) in
                        cell.title = drink.name
                        cell.color = drink.color
                        cell.addTapListener {
                            self.onItemClick?(drink)
                        }
                    }
                case .add:
                    collectionView.dequeueIdentifiableCell(indexPath) { (cell: DrinkCell) in
                        cell.title = String(localized: "Add")
                        cell.addTapListener {
                            self.onAddClick?()
                        }
                    }
                }
            })
        return dataSource
    }

    func collectionView(
        _ collectionView: UICollectionView,
        contextMenuConfigurationForItemAt indexPath: IndexPath,
        point: CGPoint
    ) -> UIContextMenuConfiguration? {
        guard let item = dataSource.itemIdentifier(for: indexPath), case let .item(drink) = item else {
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
                self.onDeleteClick?(drink)
            }

            return UIMenu(children: [moveAction, deleteAction])
        }
    }

    private typealias DataSource = UICollectionViewDiffableDataSource<Sections, DrinkCard>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Sections, DrinkCard>

    private enum Sections {
        case main
    }

    private enum DrinkCard: Hashable {
        case item(Drink)
        case add
    }
}

