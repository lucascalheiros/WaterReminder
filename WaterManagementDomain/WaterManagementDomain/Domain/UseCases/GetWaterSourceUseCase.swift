//
//  GetWaterSourceUseCaseImpl.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 09/07/23.
//

import RxSwift
import Combine

public class GetWaterSourceUseCase {
	let waterSourceRepository: WaterSourceRepository
    let getVolumeUseCase: GetVolumeFormatUseCase

	init(
        waterSourceRepository: WaterSourceRepository,
        getVolumeUseCase: GetVolumeFormatUseCase
    ) {
		self.waterSourceRepository = waterSourceRepository
        self.getVolumeUseCase = getVolumeUseCase
	}

    public func getWaterSourceList() -> AnyPublisher<[CupInfo], any Error> {
		waterSourceRepository.getWaterSourceList()
	}

    public func getWaterSourceListWithVolumeFormat() -> AnyPublisher<WaterSourceListWithVolumeFormat, any Error> {
        waterSourceRepository.getWaterSourceList()
            .combineLatest(
                getVolumeUseCase.execute().setFailureType(to: Error.self)
            ){
                WaterSourceListWithVolumeFormat(waterSourceList: $0.map{$0.cup}, volumeFormat: $1)
            }.eraseToAnyPublisher()
    }
}

