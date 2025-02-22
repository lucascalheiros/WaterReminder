//
//  CreateWaterSourceItemViewModel.swift
//  Home
//
//  Created by Lucas Calheiros on 18/12/23.
//

import Combine
import WaterManagementDomain
import RxSwift

class CreateWaterSourceItemViewModel {

    private let getVolumeFormatUseCase: GetVolumeFormatUseCase
    private let createWaterSourceUseCase: CreateWaterSourceUseCase
    private let getDrinkUseCase: GetDrinkUseCase

    var cancellableBag = Set<AnyCancellable>()

    @Published var drink: Drink?
    @Published var drinks = [Drink]()
    @Published var waterInMl = 500
    @Published var volumeFormat: SystemFormat = SystemFormat.metric
    
    lazy var waterWithFormat = $waterInMl.combineLatest($volumeFormat).map {
        Volume($0, .milliliters).to($1)
    }

    init(
        getVolumeFormatUseCase: GetVolumeFormatUseCase,
        createWaterSourceUseCase: CreateWaterSourceUseCase,
        getDrinkUseCase: GetDrinkUseCase
    ) {
        self.getVolumeFormatUseCase = getVolumeFormatUseCase
        self.createWaterSourceUseCase = createWaterSourceUseCase
        self.getDrinkUseCase = getDrinkUseCase

        getVolumeFormatUseCase.execute().sinkUI { self.volumeFormat = $0 }.store(in: &cancellableBag)
        getDrinkUseCase.execute().first().sinkUI {
            self.drink = $0.first
            self.drinks = $0
        }.store(in: &cancellableBag)
    }

    func getCurrentWaterWithFormat() -> Volume {
        Volume(waterInMl, .milliliters).to(volumeFormat)
    }

    func saveWaterSource() {
        guard let drink else { return }
        Task {
            try? await createWaterSourceUseCase.execute(Volume(waterInMl.toDouble(), .milliliters), drink)
        }
    }

}
