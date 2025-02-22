//
//  DrinkShortcutViewModel.swift
//  Home
//
//  Created by Lucas Calheiros on 12/02/25.
//

import Combine
import WaterManagementDomain

class DrinkShortcutViewModel {

    private let getDefaultDrinkShortcutsInfoUseCase: GetDefaultDrinkShortcutsInfoUseCase
    private let getVolumeFormatUseCase: GetVolumeFormatUseCase
    private let registerWaterConsumptionUseCase: RegisterWaterConsumptionUseCase

    @Published private(set) var drinkShortcutDefaultInfo: DrinkShortcutsInfo?
    private(set) var drink: Drink?

    private(set) lazy var volumeUnit = getVolumeFormatUseCase.execute().map {$0.unit}

    private var currentVolume: Volume?

    init(
        getDefaultDrinkShortcutsInfoUseCase: GetDefaultDrinkShortcutsInfoUseCase,
        getVolumeFormatUseCase: GetVolumeFormatUseCase,
        registerWaterConsumptionUseCase: RegisterWaterConsumptionUseCase
    ) {
        self.getDefaultDrinkShortcutsInfoUseCase = getDefaultDrinkShortcutsInfoUseCase
        self.getVolumeFormatUseCase = getVolumeFormatUseCase
        self.registerWaterConsumptionUseCase = registerWaterConsumptionUseCase
    }

    func loadData() {
        Task { @MainActor in
            drinkShortcutDefaultInfo  = try await getDefaultDrinkShortcutsInfoUseCase.execute()
        }
    }

    func setDrink(_ drink: Drink) {
        self.drink = drink
    }

    func setSelectedVolume(_ volume: Volume) {
        currentVolume = volume
    }

    func save() async throws {
        guard let currentVolume, let drink else { return }
        try await registerWaterConsumptionUseCase.execute(currentVolume, drink)
    }

}

