//
//  ViewController.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 07/05/23.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
	let disposeBag = DisposeBag()
	let waterPercentageHeaderView = "WaterPercentageHeaderView"
	let waterSourceListHorizontalCollectionView = "WaterSourceListHorizontalCollectionView"

    lazy var waterContainerTableView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.backgroundColor = .clear
        collectionView.register(
            WaterPercentageHeaderView.self,
            forCellWithReuseIdentifier: waterPercentageHeaderView
        )
        collectionView.register(
            WaterSourceListHorizontalCollectionView.self,
            forCellWithReuseIdentifier: waterSourceListHorizontalCollectionView
        )
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

	var viewModel: HomeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal

        view.addConstrainedSubviews(waterContainerTableView)

        NSLayoutConstraint.activate([
            waterContainerTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            waterContainerTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            waterContainerTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            waterContainerTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        default:
			fatalError("Section not implemented")
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            return bindPercentageView(collectionView, indexPath)
        case 1:
            return bindWaterSourceListCellBind(collectionView, indexPath)
        default:
            fatalError("Section not implemented")
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
            return CGSize(width: collectionView.bounds.width, height: 248)
        default:
			fatalError("Section not implemented")
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
            return UIEdgeInsets.set(inset: 0)
        default:
			fatalError("Section not implemented")
        }
    }

}
