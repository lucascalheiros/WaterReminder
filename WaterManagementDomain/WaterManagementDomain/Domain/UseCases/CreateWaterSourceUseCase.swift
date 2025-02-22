//
//  CreateWaterSourceUseCase.swift
//  WaterManagementDomain
//
//  Created by Lucas Calheiros on 13/02/25.
//

public class CreateWaterSourceUseCase {

    private let waterSourceRepository: WaterSourceRepository

    init(waterSourceRepository: WaterSourceRepository) {
        self.waterSourceRepository = waterSourceRepository
    }

    public func execute(_ volume: Volume, _ drink: Drink) async throws {
        try await waterSourceRepository.createWaterSource(volume, drink)
    }

}
