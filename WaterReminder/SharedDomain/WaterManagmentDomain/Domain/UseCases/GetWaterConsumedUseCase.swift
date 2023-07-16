//
//  GetWaterConsumedUseCase.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 09/07/23.
//

import RxSwift

class GetWaterConsumedUseCase {
	let waterConsumedRepository: WaterConsumedRepositoryProtocol

	init(waterConsumedRepository: WaterConsumedRepositoryProtocol) {
		self.waterConsumedRepository = waterConsumedRepository
	}

	func getWaterConsumedByPeriod(startPeriod: Date, endPeriod: Date) -> Observable<Int> {
		waterConsumedRepository.getWaterConsumedList()
			.map {
				$0.filter { startPeriod < $0.consumptionTime && $0.consumptionTime < endPeriod }
					.map { $0.volume }.reduce(0, { $0 + $1 })
			}
	}

	func getWaterConsumedToday() -> Observable<Int> {
		let currentDate = Date()
		let startOfDay = currentDate.startOfDay
		let endOfDay = currentDate.endOfDay
		return getWaterConsumedByPeriod(startPeriod: startOfDay, endPeriod: endOfDay)
	}
}
