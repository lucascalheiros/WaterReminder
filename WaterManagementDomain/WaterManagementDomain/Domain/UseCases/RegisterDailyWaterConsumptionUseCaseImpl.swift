//
//  RegisterDailyWaterConsumptionUseCaseImpl.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 08/06/23.
//

import RxSwift

internal class RegisterDailyWaterConsumptionUseCaseImpl: RegisterDailyWaterConsumptionUseCase {
	let dailyWaterConsumptionRepository: DailyWaterConsumptionRepository

	init(dailyWaterConsumptionRepository: DailyWaterConsumptionRepository) {
		self.dailyWaterConsumptionRepository = dailyWaterConsumptionRepository
	}

	func registerDailyWaterConsumption(waterValue: Int) -> Completable {
		dailyWaterConsumptionRepository.setDailyWaterConsumption(waterValue)
	}
}
