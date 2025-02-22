//
//  UpdateWaterSourceUseCase.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 09/07/23.
//


public class UpdateWaterSourceUseCase {

	private let waterSourceRepository: WaterSourceRepository

	init(waterSourceRepository: WaterSourceRepository) {
		self.waterSourceRepository = waterSourceRepository
	}

    public func execute(_ waterSources: [WaterSource]) async throws {
        try await waterSourceRepository.updateWaterSources(waterSources: waterSources)
	}

}
