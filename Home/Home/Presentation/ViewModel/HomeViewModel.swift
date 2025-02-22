//
//  HomeViewModel.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 12/05/23.
//

import Foundation

import WaterManagementDomain
import Combine

class HomeViewModel {
    private	let deleteWaterSourceUseCase: DeleteWaterSourceUseCase
    private	let getSortedWaterSourceUseCase: GetSortedWaterSourceUseCase
    private	let registerWaterConsumedUseCase: RegisterWaterConsumptionUseCase
    private	let getDailyWaterConsumptionUseCase: GetDailyWaterConsumptionUseCase
    private	let getWaterConsumedUseCase: GetWaterConsumedUseCase
    private	let getVolumeFormatUseCase: GetVolumeFormatUseCase
    private let getConsumptionSummaryUseCase: GetConsumptionSummaryUseCase
    private let homeFlowStepper: HomeFlowStepper
    private let getDrinkUseCase: GetDrinkUseCase
    private let deleteDrinkUseCase: DeleteDrinkUseCase

    private var cancellableBag = Set<AnyCancellable>()

    lazy var cups = {
        getSortedWaterSourceUseCase.execute()
    }()

    lazy var expectedWaterConsumptionInML: AnyPublisher<Int, Never> = {
        getDailyWaterConsumptionUseCase.lastDailyWaterConsumption().map {
            $0?.expectedVolume ?? 0
        }.catchNever()
    }()

    @Published private var todayEndOfDay = Date().endOfDay

    lazy var drinks = getDrinkUseCase.execute()

    lazy var currentWaterConsumedInML: AnyPublisher<Volume, Never> = {
        $todayEndOfDay.removeDuplicates().flatMap { [weak self] in
            self?.getWaterConsumedUseCase
                .getWaterConsumedVolumeByPeriod($0.startOfDay, $0.endOfDay)
                .catchNever() ?? Empty<Volume, Never>().eraseToAnyPublisher()
        }.eraseToAnyPublisher()
    }()

    lazy var consumedPercentage: AnyPublisher<Double, Never>  = {
        expectedWaterConsumptionInML.combineLatest(currentWaterConsumedInML) { total, current in
            return total == 0 ? 0.0 : current.to(.milliliters).value / Double(total)
        }.eraseToAnyPublisher()
    }()

    lazy var volumeFormat = {
        getVolumeFormatUseCase.execute()
    }()

    lazy var volumeFormatText = {
        volumeFormat.map { $0.formatDisplay }
    }()

    lazy var consumedQuantityText = {
        currentWaterConsumedInML.map {
            $0.formattedValue
        }
    }()

    lazy var remainingQuantityText = {
        expectedWaterConsumptionInML.combineLatest(currentWaterConsumedInML) { total, current in
            let difference = total - current.to(.milliliters).value.toInt()
            if difference <= 0 {
                return String(localized: "home.goalAchieved")
            }
            let remainingWaterWithFormat = Volume(difference, .milliliters).to(current.unit).formattedValueAndUnit
            return String(localized: "home.volume.remaining.\(remainingWaterWithFormat)")
        }
    }()

    private(set) lazy var dailyConsumedWaterPercentageWithWaterType = {
        $todayEndOfDay
            .setFailureType(to: Error.self)
            .removeDuplicates()
            .flatMap(getConsumptionSummaryUseCase.execute)
            .catchNever()
    }()

    init (
        getDailyWaterConsumptionUseCase: GetDailyWaterConsumptionUseCase,
        getWaterConsumedUseCase: GetWaterConsumedUseCase,
        registerWaterConsumedUseCase: RegisterWaterConsumptionUseCase,
        deleteWaterSourceUseCase: DeleteWaterSourceUseCase,
        getSortedWaterSourceUseCase: GetSortedWaterSourceUseCase,
        getVolumeFormatUseCase: GetVolumeFormatUseCase,
        homeFlowStepper: HomeFlowStepper,
        getConsumptionSummaryUseCase: GetConsumptionSummaryUseCase,
        getDrinkUseCase: GetDrinkUseCase,
        deleteDrinkUseCase: DeleteDrinkUseCase
    ) {
        self.getDailyWaterConsumptionUseCase = getDailyWaterConsumptionUseCase
        self.getWaterConsumedUseCase = getWaterConsumedUseCase
        self.registerWaterConsumedUseCase = registerWaterConsumedUseCase
        self.deleteWaterSourceUseCase = deleteWaterSourceUseCase
        self.getSortedWaterSourceUseCase = getSortedWaterSourceUseCase
        self.getVolumeFormatUseCase = getVolumeFormatUseCase
        self.homeFlowStepper = homeFlowStepper
        self.getConsumptionSummaryUseCase = getConsumptionSummaryUseCase
        self.getDrinkUseCase = getDrinkUseCase
        self.deleteDrinkUseCase = deleteDrinkUseCase
    }

    func updateDayIfNecessary() {
        todayEndOfDay = Date().endOfDay
    }

    func addWaterVolume(waterSource: WaterSource) {
        Task {
            do {
                try await registerWaterConsumedUseCase.execute(waterSource)
            } catch {
                print(error)
            }
        }
    }

    func deleteCup(_ cup: WaterSource) {
        Task {
            try? await deleteWaterSourceUseCase.execute(cup)
        }
    }

    func deleteDrink(_ drink: Drink) {
        Task {
            try? await deleteDrinkUseCase.execute(drink)
        }
    }

    func showEditDrink() {

    }

    func showWaterSourceModal() {
        homeFlowStepper.showWaterSourceModal()
    }

    func showAddCupModal() {
        homeFlowStepper.showCreateWaterSource()
    }

    func showCupEditor() {
        homeFlowStepper.showCupEditor()
    }

    func showAddDrink() {
        homeFlowStepper.steps.accept(HomeFlowSteps.addDrink)
    }

    func showDrinkShortcut(_ drink: Drink) {
        homeFlowStepper.steps.accept(HomeFlowSteps.drinkShortcut(drink))
    }
}

