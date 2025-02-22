//
//  HomeVC.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 07/05/23.
//

import UIKit
import Combine
import Core

class HomeVC: UIViewController {
    static func newInstance(viewModel: HomeViewModel) -> HomeVC {
        HomeVC(viewModel: viewModel)
    }

    private var cancellableBag: Set<AnyCancellable> = []

    private lazy var percentageView: WaterPercentage = {
        let view = WaterPercentage()
        return view
    }()

    private lazy var drinkList: DrinkListHorizontalCollectionView = {
        let view = DrinkListHorizontalCollectionView()
        view.onItemClick = viewModel.showDrinkShortcut
        view.onAddClick = viewModel.showAddDrink
        view.onEditClick = viewModel.showEditDrink
        view.onDeleteClick = viewModel.deleteDrink
        return view
    }()

    private lazy var cupList: WaterSourceListHorizontalCollectionView = {
        let view = WaterSourceListHorizontalCollectionView(frame: CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: waterSourceSectionHeight)))
        view.onItemClick = viewModel.addWaterVolume
        view.onAddClick = viewModel.showAddCupModal
        view.onEditClick = viewModel.showCupEditor
        view.onDeleteClick = viewModel.deleteCup
        return view
    }()

    private lazy var verticalStack = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fillProportionally
        stack.alignment = .center
        return stack
    }()

    private let viewModel: HomeViewModel

    private let waterSourceSectionHeight: CGFloat = 208

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        listenLifecycle()
        prepareConfiguration()
        prepareConstraints()
    }

    private func listenLifecycle() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }

    @objc func appMovedToForeground() {
        viewModel.updateDayIfNecessary()
    }

    private func prepareConfiguration() {
        view.backgroundColor = AppColorGroup.background.color

        viewModel.dailyConsumedWaterPercentageWithWaterType
            .sinkUI { [weak self] summary in
                self?.percentageView.setPercentage(summary.percentageForDrink)
            }.store(in: &cancellableBag)

        viewModel.currentWaterConsumedInML
            .sinkUI { [weak self] waterWithFormat in
                self?.percentageView.setSecondaryText(text: waterWithFormat.formattedValue)
                self?.percentageView.setFormatText(text: waterWithFormat.unit.formatted)
            }.store(in: &cancellableBag)

        viewModel.remainingQuantityText
            .sinkUI { [weak self] text in
                self?.percentageView.setInformativeText(text: text)
            }.store(in: &cancellableBag)

        viewModel.cups.catchNever()
            .sinkUI { [weak self] in
                self?.cupList.applySnapshot($0)
            }.store(in: &cancellableBag)

        viewModel.drinks.catchNever()
            .sinkUI { [weak self] in
                self?.drinkList.applySnapshot(drinks: $0)
            }.store(in: &cancellableBag)

        viewModel.volumeFormat
            .receive(on: RunLoop.main)
            .assign(to: \.volumeFormat, on: cupList)
            .store(in: &cancellableBag)
    }

    private func prepareConstraints() {
        view.addConstrainedSubview(verticalStack)

        verticalStack.addConstrainedArrangedSubviews(percentageView, cupList, drinkList)

        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            verticalStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            verticalStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            verticalStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            percentageView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
            percentageView.heightAnchor.constraint(lessThanOrEqualTo: percentageView.widthAnchor),

            cupList.widthAnchor.constraint(equalTo: view.widthAnchor),
            cupList.heightAnchor.constraint(equalToConstant: waterSourceSectionHeight),

            drinkList.heightAnchor.constraint(equalToConstant: 40),
            drinkList.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
}
