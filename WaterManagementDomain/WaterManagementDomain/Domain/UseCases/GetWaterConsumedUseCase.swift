//
//  GetWaterConsumedUseCaseImpl.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 09/07/23.
//

import RxSwift
import Common
import Foundation
import Combine

public class GetWaterConsumedUseCase {
	let waterConsumedRepository: WaterConsumedRepository
	let getVolumeFormatUseCase: GetVolumeFormatUseCase

	init(
		waterConsumedRepository: WaterConsumedRepository,
		getVolumeFormatUseCase: GetVolumeFormatUseCase
	) {
		self.waterConsumedRepository = waterConsumedRepository
		self.getVolumeFormatUseCase = getVolumeFormatUseCase
	}

    public func getWaterConsumedVolumeByPeriod(_ startPeriod: Date, _ endPeriod: Date) -> AnyPublisher<Volume, any Error> {
		wrapWithFormat(
			getWaterConsumedList(startPeriod, endPeriod)
                .map { $0.map { $0.hydrationVolume }.reduce(0, +) }
                .eraseToAnyPublisher()
		)
	}

	private func wrapWithFormat(_ waterInMl: AnyPublisher<Double, any Error>) -> AnyPublisher<Volume, any Error> {
        return waterInMl.combineLatest(getVolumeFormatUseCase.execute().setFailureType(to: Error.self)) { volume, format in
            return Volume(volume, .milliliters).to(format)
        }.eraseToAnyPublisher()
	}
	
    public func getWaterConsumedList(_ startPeriod: Date? = nil, _ endPeriod: Date? = nil) -> AnyPublisher<[ConsumedCupInfo], any Error> {
		return waterConsumedRepository.getWaterConsumedList()
			.map {
                $0.filter { item in
                    let inStartPeriod = startPeriod.unwrapLet { $0 < item.consumedCup.consumptionTime } ?? true
                    let inEndPeriod = endPeriod.unwrapLet { item.consumedCup.consumptionTime < $0 } ?? true
                    return inStartPeriod && inEndPeriod
                }
            }.eraseToAnyPublisher()
	}
}
