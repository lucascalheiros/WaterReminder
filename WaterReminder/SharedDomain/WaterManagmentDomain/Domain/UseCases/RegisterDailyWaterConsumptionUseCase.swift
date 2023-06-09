//
//  RegisterDailyWaterConsumptionUseCase.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 08/06/23.
//

import RxSwift

class RegisterDailyWaterConsumptionUseCase {
	let dailyWaterConsumptionRepository: DailyWaterConsumptionRepositoryProtocol

	internal init(dailyWaterConsumptionRepository: DailyWaterConsumptionRepositoryProtocol) {
		self.dailyWaterConsumptionRepository = dailyWaterConsumptionRepository
	}

	func registerDailyWaterConsumption(waterValue: Int) -> Completable {
		dailyWaterConsumptionRepository.setDailyWaterConsumption(waterValue)
	}
}
