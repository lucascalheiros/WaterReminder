//
//  ManageWaterSourceUseCase.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 09/07/23.
//

import RxSwift

internal class ManageWaterSourceUseCase: ManageWaterSourceUseCaseProtocol {
	let waterSourceRepository: WaterSourceRepositoryProtocol

	init(waterSourceRepository: WaterSourceRepositoryProtocol) {
		self.waterSourceRepository = waterSourceRepository
	}

	func createWaterSource(waterVolume: Int, waterSourceType: WaterSourceType) -> Completable {
		waterSourceRepository.createWaterSource(waterSource: WaterSource(volume: waterVolume, waterSourceType: waterSourceType))
	}

	func updateWaterSourcePinState(waterSource: WaterSource, pinnedState: Bool) -> Completable {
		waterSourceRepository.updateWaterSourcePinState(waterSource: waterSource, isPinned: pinnedState)
	}
}
