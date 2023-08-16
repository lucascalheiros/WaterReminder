//
//  ViewController.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 07/05/23.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController {
	let disposeBag = DisposeBag()

	let sections = HomeSection.allCases

    lazy var waterContainerTableView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
		registerCells(collectionView)
		collectionView.backgroundColor = .clear
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
}

enum HomeSection: CaseIterable {
	case mainWaterTracker
	case waterSourceList

	func itemsForSection() -> Int {
		switch self {
		case .mainWaterTracker:
			return 1
		case .waterSourceList:
			return 1
		}
	}
}
