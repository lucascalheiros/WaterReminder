//
//  GetWaterSourceUseCase.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 09/07/23.
//

import RxSwift

internal class GetWaterSourceUseCase: GetWaterSourceUseCaseProtocol {
	let waterSourceRepository: WaterSourceRepositoryProtocol
    let getVolumeUseCase: GetVolumeFormatUseCaseProtocol

	init(
        waterSourceRepository: WaterSourceRepositoryProtocol,
        getVolumeUseCase: GetVolumeFormatUseCaseProtocol
    ) {
		self.waterSourceRepository = waterSourceRepository
        self.getVolumeUseCase = getVolumeUseCase
	}

	func getWaterSourceList() -> Observable<[WaterSource]> {
		waterSourceRepository.getWaterSourceList()
	}

    func getWaterSourceListWithVolumeFormat() -> Observable<WaterSourceListWithVolumeFormat> {
        Observable.combineLatest(waterSourceRepository.getWaterSourceList(), getVolumeUseCase.volumeFormat()) {
            WaterSourceListWithVolumeFormat(waterSourceList: $0, volumeFormat: $1)
        }
    }
}
