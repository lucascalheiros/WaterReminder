//
//  ViewController.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 07/05/23.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    lazy var waterContainerTableView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.backgroundColor = .clear
        collectionView.register(WaterPercentageHeaderView.self, forCellWithReuseIdentifier: "WaterPercentageHeaderView")
        collectionView.register(WaterContainerCellView.self, forCellWithReuseIdentifier: "WaterContainerCellView")
        collectionView.register(WaterSourceListHorizontalCollectionView.self, forCellWithReuseIdentifier: "WaterSourceListHorizontalCollectionView")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    lazy var waterContainerList: [WaterSource] = []
    private let itemsPerRow: CGFloat = 2
    
    lazy var viewModel = HomeViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal

        view.addSubview(waterContainerTableView)
        
        viewModel.updateWaterSourceList()
        
        NSLayoutConstraint.activate([
            waterContainerTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            waterContainerTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            waterContainerTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            waterContainerTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        ])
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 0
        case 2:
            return 1
        default:
            fatalError("init(coder:) has not been implemented")
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "WaterPercentageHeaderView",
                for: indexPath
            ) as! WaterPercentageHeaderView

            return cell.bind(percentageObservable: viewModel.consumedPercentage, secondaryText: viewModel.consumedQuantityText)
        case 1:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "WaterContainerCellView",
                for: indexPath
            ) as! WaterContainerCellView
            let waterContainer = waterContainerList[indexPath.row]
            cell.bindData(waterContainer: waterContainer)
            cell.bindListener {
                self.viewModel.addWaterVolume(waterContainer: waterContainer)
            }
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "WaterSourceListHorizontalCollectionView",
                for: indexPath
            ) as! WaterSourceListHorizontalCollectionView
            viewModel.waterSourceList.subscribe(onNext: {
                cell.waterContainerList = $0
                cell.waterContainerTableView.reloadData()
            })
            
            cell.clickListener = { waterContainer in
                self.viewModel.addWaterVolume(waterContainer: waterContainer)
            }
            return cell
        default:
            fatalError("init(coder:) has not been implemented")
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let horizontalPadding = insetBySection(section: indexPath.section).horizontalPadding()
        
        switch indexPath.section {
        case 0:
            return CGSize(width: collectionView.bounds.width - horizontalPadding, height: 300)
        case 1:
            let itemSpacing = 16.0
            let availableWidth = view.frame.width - horizontalPadding - itemSpacing
            let widthPerItem = availableWidth / itemsPerRow
            return CGSize(width: widthPerItem, height: 100)
        case 2:
            return CGSize(width: collectionView.bounds.width, height: 248)
        default:
            fatalError("init(coder:) has not been implemented")
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
        switch section {
        case 0:
            return UIEdgeInsets.vertical(inset: 8).horizontal(inset: 16)
        case 1:
            return UIEdgeInsets.vertical(inset: 8).horizontal(inset: 16)
        case 2:
            return UIEdgeInsets.set(inset: 0)
        default:
            fatalError("init(coder:) has not been implemented")
        }
    }
    
}



extension WaterPercentageHeaderView {
    func bind(percentageObservable: Observable<Double>, secondaryText: Observable<String>) -> WaterPercentageHeaderView {
        percentageObservable.subscribe(onNext: { percentage in
            self.setPercentage(percentage: percentage)
        }).disposed(by: disposeBag)
        secondaryText.subscribe(onNext: { text in
            self.setSecondaryText(text: text)
        }).disposed(by: disposeBag)
        
        return self
    }
}
