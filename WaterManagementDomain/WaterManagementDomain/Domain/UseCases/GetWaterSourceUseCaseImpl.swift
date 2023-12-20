//
//  GetWaterSourceUseCaseImpl.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 09/07/23.
//

import RxSwift

internal class GetWaterSourceUseCaseImpl: GetWaterSourceUseCase {
	let waterSourceRepository: WaterSourceRepository
    let getVolumeUseCase: GetVolumeFormatUseCase

	init(
        waterSourceRepository: WaterSourceRepository,
        getVolumeUseCase: GetVolumeFormatUseCase
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
