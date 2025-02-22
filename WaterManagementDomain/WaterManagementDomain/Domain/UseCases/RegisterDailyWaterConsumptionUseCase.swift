//
//  RegisterDailyWaterConsumptionUseCase.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 08/06/23.
//

import RxSwift

public class RegisterDailyWaterConsumptionUseCase {
	let dailyWaterConsumptionRepository: DailyWaterConsumptionRepository

	init(dailyWaterConsumptionRepository: DailyWaterConsumptionRepository) {
		self.dailyWaterConsumptionRepository = dailyWaterConsumptionRepository
	}

    public func registerDailyWaterConsumption(waterValue: Int) async throws {
        try await dailyWaterConsumptionRepository.setDailyWaterConsumption(Volume(Double(waterValue), .milliliters))
	}
}
