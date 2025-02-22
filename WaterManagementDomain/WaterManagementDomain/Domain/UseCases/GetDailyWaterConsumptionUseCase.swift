//
//  GetDailyWaterConsumptionUseCase.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 07/07/23.
//

import RxSwift
import Combine

public class GetDailyWaterConsumptionUseCase {
	let dailyWaterConsumptionRepository: DailyWaterConsumptionRepository

	init(
		dailyWaterConsumptionRepository: DailyWaterConsumptionRepository
	) {
		self.dailyWaterConsumptionRepository = dailyWaterConsumptionRepository
	}

    public func getDailyWaterConsumptionList() -> AnyPublisher<[DailyWaterConsumption], any Error> {
		dailyWaterConsumptionRepository.getDailyWaterConsumptionList()
	}

    public func lastDailyWaterConsumption() -> AnyPublisher<DailyWaterConsumption?, any Error> {
        getDailyWaterConsumptionList().map { $0.max(by: {$0.date < $1.date}) }.eraseToAnyPublisher()
	}
}
