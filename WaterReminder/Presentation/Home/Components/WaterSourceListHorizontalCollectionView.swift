//
//  ViewController.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 07/05/23.
//

import UIKit
import RxSwift

class WaterSourceListHorizontalCollectionView: UICollectionViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    lazy var waterContainerTableView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.backgroundColor = .clear
        collectionView.register(WaterContainerCellView.self, forCellWithReuseIdentifier: "WaterContainerCellView")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    

    var waterContainerList: [WaterSource] = []
    var clickListener: (WaterSource) -> Void = {_ in }

    
    private let itemsPerRow: CGFloat = 2
    
    private let sectionInsets = UIEdgeInsets.set(inset: 16)
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(waterContainerTableView)
        
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return waterContainerList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "WaterContainerCellView",
            for: indexPath
        ) as! WaterContainerCellView
        let waterContainer = waterContainerList[indexPath.row]
        cell.bindData(waterContainer: waterContainer)
        cell.bindListener {
            self.clickListener(waterContainer)
        }
        return cell
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
}

