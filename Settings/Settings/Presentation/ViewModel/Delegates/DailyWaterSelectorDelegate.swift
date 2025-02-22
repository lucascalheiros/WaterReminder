//
//  DailyWaterSelectorDelegate.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 03/08/23.
//

import WaterManagementDomain
import Combine

class DailyWaterSelectorDelegate {
    private let getDailyWaterConsumptionUseCase: GetDailyWaterConsumptionUseCase
    private let registerDailyWaterConsumptionUseCase: RegisterDailyWaterConsumptionUseCase
    private let getVolumeFormatUseCase: GetVolumeFormatUseCase
    private let registerVolumeFormatUseCase: RegisterVolumeFormatUseCase

    lazy var volumeWithFormat = {
        getDailyWaterConsumptionUseCase.lastDailyWaterConsumption().combineLatest(
            volumeFormat.setFailureType(to: Error.self)
        ) { lastDailyWaterConsumption, volumeFormat in
            Volume(lastDailyWaterConsumption?.expectedVolume ?? 0, .milliliters).to(volumeFormat)
        }.catch{_ in Empty<Volume, Never>()}
    }()

    lazy var volumeFormat = getVolumeFormatUseCase.execute()

    init(
        getDailyWaterConsumptionUseCase: GetDailyWaterConsumptionUseCase,
        registerDailyWaterConsumptionUseCase: RegisterDailyWaterConsumptionUseCase,
        getVolumeFormatUseCase: GetVolumeFormatUseCase,
        registerVolumeFormatUseCase: RegisterVolumeFormatUseCase
    ) {
        self.getDailyWaterConsumptionUseCase = getDailyWaterConsumptionUseCase
        self.registerDailyWaterConsumptionUseCase = registerDailyWaterConsumptionUseCase
        self.getVolumeFormatUseCase = getVolumeFormatUseCase
        self.registerVolumeFormatUseCase = registerVolumeFormatUseCase
    }

    func setVolumeAndFormat(_ volumeInFormat: Float, _ format: SystemFormat) {
        let volumeMetric = Int(format.toMetric(volumeInFormat))
        Task {
            try await registerDailyWaterConsumptionUseCase.registerDailyWaterConsumption(waterValue: volumeMetric)
            registerVolumeFormatUseCase.setVolumeFormat(format)
        }
    }

    func setFormat(_ format: SystemFormat) {
        registerVolumeFormatUseCase.setVolumeFormat(format)
    }
}
