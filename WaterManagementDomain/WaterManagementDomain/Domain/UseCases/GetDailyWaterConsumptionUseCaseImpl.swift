//
//  GetDailyWaterConsumptionUseCaseImpl.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 07/07/23.
//

import RxSwift

internal class GetDailyWaterConsumptionUseCaseImpl: GetDailyWaterConsumptionUseCase {
	let dailyWaterConsumptionRepository: DailyWaterConsumptionRepository

	init(
		dailyWaterConsumptionRepository: DailyWaterConsumptionRepository
	) {
		self.dailyWaterConsumptionRepository = dailyWaterConsumptionRepository
	}

	func getDailyWaterConsumptionList() -> Observable<[DailyWaterConsumption]> {
		dailyWaterConsumptionRepository.getDailyWaterConsumptionList()
	}

	func lastDailyWaterConsumption() -> Observable<DailyWaterConsumption?> {
		getDailyWaterConsumptionList().map { $0.max(by: {$0.date < $1.date}) }
	}
}
