//
//  RegisterWaterConsumedUseCaseImpl.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 09/07/23.
//

import RxSwift

internal class RegisterWaterConsumedUseCaseImpl: RegisterWaterConsumedUseCaseProtocol {
	let waterConsumedRepository: WaterConsumedRepository

	init(waterConsumedRepository: WaterConsumedRepository) {
		self.waterConsumedRepository = waterConsumedRepository
	}

	func registerWaterConsumption(waterVolume: Int, sourceType: WaterSourceType) -> Completable {
		waterConsumedRepository.registerWaterConsumption(waterVolume: waterVolume, sourceType: sourceType)
	}
}
