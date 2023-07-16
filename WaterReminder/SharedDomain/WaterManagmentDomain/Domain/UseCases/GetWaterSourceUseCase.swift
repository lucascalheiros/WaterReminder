//
//  GetWaterSourceUseCase.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 09/07/23.
//

import RxSwift

class GetWaterSourceUseCase {
	let waterSourceRepository: WaterSourceRepositoryProtocol

	init(waterSourceRepository: WaterSourceRepositoryProtocol) {
		self.waterSourceRepository = waterSourceRepository
	}

	func getWaterSourceList() -> Observable<[WaterSource]>{
		waterSourceRepository.getWaterSourceList()
	}
}
