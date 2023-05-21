//
//  ViewController.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 07/05/23.
//

import UIKit
import RxSwift

enum Section {
    case main
}

class WaterSourceListHorizontalCollectionView: UICollectionViewCell, UICollectionViewDelegateFlowLayout {
    
    lazy var waterContainerTableView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.backgroundColor = .clear
        collectionView.register(WaterContainerCellView.self, forCellWithReuseIdentifier: "WaterContainerCellView")
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    lazy var dataSource: DataSource = makeDatasource()
    
    var waterContainerList: [WaterSource] = []
    var clickListener: (WaterSource) -> Void = {_ in }
    
    
    private let itemsPerRow: CGFloat = 2
    
    private let sectionInsets = UIEdgeInsets.set(inset: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(waterContainerTableView)
        
        waterContainerTableView.dataSource = dataSource
        applySnapshot()
        
        NSLayoutConstraint.activate([
            waterContainerTableView.topAnchor.constraint(equalTo: topAnchor),
            waterContainerTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            waterContainerTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            waterContainerTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func applySnapshot(animatingDifferences: Bool = true) {
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
                    withReuseIdentifier: "WaterContainerCellView",
                    for: indexPath
                ) as! WaterContainerCellView
                cell.bindData(waterContainer: waterSource)
                cell.bindListener {
                    self.clickListener(waterSource)
                }
                return cell
            })
        return dataSource
    }
    
}

typealias DataSource = UICollectionViewDiffableDataSource<Section, WaterSource>
typealias Snapshot = NSDiffableDataSourceSnapshot<Section, WaterSource>


