//
//  DeleteWaterConsumedUseCase.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 09/07/23.
//


public class DeleteWaterConsumedUseCase {
	private let waterConsumedRepository: WaterConsumedRepository

	init(waterConsumedRepository: WaterConsumedRepository) {
		self.waterConsumedRepository = waterConsumedRepository
	}

    public func execute(_ waterConsumed: WaterConsumed) async throws {
        try await waterConsumedRepository.deleteWaterConsumed(waterConsumed)
    }
}
