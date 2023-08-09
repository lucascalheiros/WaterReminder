//
//  ViewController.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 07/05/23.
//

import UIKit
import RxSwift
import RxRelay

class WaterSourceListHorizontalCollectionView: UICollectionViewCell, UICollectionViewDelegateFlowLayout {
	let disposeBag = DisposeBag()
	let waterContainerCellView = "WaterContainerCellView"

    lazy var waterContainerTableView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.backgroundColor = .clear
        collectionView.register(
            WaterSourceCellView.self,
            forCellWithReuseIdentifier: waterContainerCellView
        )
        collectionView.delegate = self
        return collectionView
    }()

    lazy var dataSource: DataSource = makeDatasource()

    var waterSourceListener: WaterSourceListener?

    private let itemsPerRow: CGFloat = 2

    private let sectionInsets = UIEdgeInsets.set(inset: 16)

	let volumeFormatBehaviorRelay = BehaviorRelay(value: VolumeFormat.metric)

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

    func applySnapshot(waterContainerList: [WaterSource], animatingDifferences: Bool = true) {
      var snapshot = Snapshot()
      snapshot.appendSections([.main])
      snapshot.appendItems(waterContainerList)
      dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let availableWidth = frame.width - 48
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: 100)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return sectionInsets.bottom
    }

    func makeDatasource() -> DataSource {
        let dataSource = DataSource(
            collectionView: self.waterContainerTableView,
            cellProvider: { (collectionView, indexPath, waterSource) ->
                UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(
					withReuseIdentifier: self.waterContainerCellView,
                    for: indexPath
                )
				if let cell = cell as? WaterSourceCellView {
					self.volumeFormatBehaviorRelay.bind(to: cell.volumeFormat).disposed(by: self.disposeBag)
					cell.waterSource.accept(waterSource)

					cell.listener = WaterSourceListener(
						itemClickListener: { [weak self] in
							self?.waterSourceListener?.itemClickListener($0)
						},
						pinClickListener: { [weak self] in
							self?.waterSourceListener?.pinClickListener($0)
						}
					)
				}
                return cell
            })
        return dataSource
    }

}

typealias DataSource = UICollectionViewDiffableDataSource<Section, WaterSource>
typealias Snapshot = NSDiffableDataSourceSnapshot<Section, WaterSource>

enum Section {
	case main
}
