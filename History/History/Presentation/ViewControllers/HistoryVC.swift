//
//  HistoryViewController.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 14/05/23.
//

import UIKit
import RxSwift
import RxCocoa
import WaterManagementDomain
import Components

class HistoryVC: UICollectionViewController {
    static func newInstance(historyViewModel: HistoryViewModel) -> HistoryVC {
        HistoryVC(historyViewModel: historyViewModel)
    }

	let disposeBag = DisposeBag()
	let historyViewModel: HistoryViewModel

    lazy var diffableDatasource: DataSource = makeDatasource()

	var todayWaterConsumedList: [WaterConsumed] = []

	init(historyViewModel: HistoryViewModel) {
		self.historyViewModel = historyViewModel
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		super.init(collectionViewLayout: layout)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

        prepareConfiguration()
        loadData()
	}

    func loadData() {
        historyViewModel.waterConsumedByDay.subscribe(onNext: {
            self.applySnapshot(waterConsumedByDay: $0, animatingDifferences: true)
        }).disposed(by: disposeBag)
    }

    func prepareConfiguration() {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.backgroundColor = DefaultComponentsTheme.current.background.color
        configuration.showsSeparators = true
        configuration.separatorConfiguration.bottomSeparatorInsets = NSDirectionalEdgeInsets()
        configuration.headerMode = .supplementary

        // TODO Default height for section is 17.6667, so there is a warning for constraint satisfaction
        //    inside TodayConsumptionSection as ios (awfully) does not provide a way to set the section
        //    height using UICollectionLayoutListConfiguration, fix in the future, lowest priority since its
        //    functioning correctly
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout.list(using: configuration)
        view.backgroundColor = DefaultComponentsTheme.current.background.color
        collectionView.backgroundColor = DefaultComponentsTheme.current.background.color

        // Set the data source and delegate
        collectionView.dataSource = diffableDatasource
        collectionView.delegate = self

        registerCells()
        configureHeader()
    }
}
