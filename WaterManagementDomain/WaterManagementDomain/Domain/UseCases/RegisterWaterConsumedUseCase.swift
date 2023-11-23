//
//  RegisterWaterConsumedUseCase.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 09/07/23.
//

import RxSwift

internal class RegisterWaterConsumedUseCase: RegisterWaterConsumedUseCaseProtocol {
	let waterConsumedRepository: WaterConsumedRepositoryProtocol

	init(waterConsumedRepository: WaterConsumedRepositoryProtocol) {
		self.waterConsumedRepository = waterConsumedRepository
	}

	func registerWaterConsumption(waterVolume: Int, sourceType: WaterSourceType) -> Completable {
		waterConsumedRepository.registerWaterConsumption(waterVolume: waterVolume, sourceType: sourceType)
	}
}
