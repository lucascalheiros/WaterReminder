//
//  ManageWaterSourceUseCaseImpl.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 09/07/23.
//

import RxSwift

internal class ManageWaterSourceUseCaseImpl: ManageWaterSourceUseCase {
    
	let waterSourceRepository: WaterSourceRepository

	init(waterSourceRepository: WaterSourceRepository) {
		self.waterSourceRepository = waterSourceRepository
	}

	func createWaterSource(waterVolume: Int, waterSourceType: WaterSourceType) -> Completable {
		waterSourceRepository.createWaterSource(waterSource: WaterSource(volume: waterVolume, waterSourceType: waterSourceType))
	}

	func updateWaterSourcePinState(waterSource: WaterSource, pinnedState: Bool) -> Completable {
		waterSourceRepository.updateWaterSourcePinState(waterSource: waterSource, isPinned: pinnedState)
	}

	func updateWaterSources(waterSources: [WaterSource]) -> Completable {
		waterSourceRepository.updateWaterSources(waterSources: waterSources)
	}

    func deleteWaterSource(waterSource: WaterSource) -> RxSwift.Completable {
        waterSourceRepository.deleteWaterSource(waterSource: waterSource)
    }

}
