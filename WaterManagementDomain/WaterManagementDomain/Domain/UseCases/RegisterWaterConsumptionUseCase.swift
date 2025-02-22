//
//  RegisterWaterConsumptionUseCase.swift
//  WaterManagementDomain
//
//  Created by Lucas Calheiros on 13/02/25.
//

public class RegisterWaterConsumptionUseCase {
    private let waterConsumedRepository: WaterConsumedRepository

    init(waterConsumedRepository: WaterConsumedRepository) {
        self.waterConsumedRepository = waterConsumedRepository
    }

    public func execute(_ volume: Volume, _ drink: Drink) async throws {
        try await waterConsumedRepository.registerWaterConsumption(volume, drink)
    }

    public func execute(_ cup: WaterSource) async throws {
        try await waterConsumedRepository.registerWaterConsumption(cup: cup)
    }

}
