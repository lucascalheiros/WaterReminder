//
//  GetWaterSourceUseCase.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 09/07/23.
//

import RxSwift

internal class GetWaterSourceUseCase: GetWaterSourceUseCaseProtocol {
	let waterSourceRepository: WaterSourceRepositoryProtocol

	init(waterSourceRepository: WaterSourceRepositoryProtocol) {
		self.waterSourceRepository = waterSourceRepository
	}

	func getWaterSourceList() -> Observable<[WaterSource]> {
		waterSourceRepository.getWaterSourceList()
	}
}
