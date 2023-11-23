//
//  HomeVC.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 07/05/23.
//

import UIKit
import RxSwift
import Swinject

class HomeVC: UIViewController {
	let disposeBag = DisposeBag()

	let sections = HomeSections.allCases

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

	let viewModel: HomeViewModel

	init(viewModel: HomeViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    static func newInstance(viewModel: HomeViewModel) -> HomeVC {
        HomeVC(viewModel: viewModel)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
		prepareConfiguration()
		prepareConstraints()
    }

	func prepareConfiguration() {
		view.backgroundColor = .systemTeal
	}

	func prepareConstraints() {
		view.addConstrainedSubviews(waterContainerTableView)

		NSLayoutConstraint.activate([
			waterContainerTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			waterContainerTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			waterContainerTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			waterContainerTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
		])
	}
}
