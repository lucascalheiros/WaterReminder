//
//  GetWaterConsumedUseCaseImpl.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 09/07/23.
//

import RxSwift
import Common
import Foundation

internal class GetWaterConsumedUseCaseImpl: GetWaterConsumedUseCase {
	let waterConsumedRepository: WaterConsumedRepository
	let getVolumeFormatUseCase: GetVolumeFormatUseCase

	init(
		waterConsumedRepository: WaterConsumedRepository,
		getVolumeFormatUseCase: GetVolumeFormatUseCase
	) {
		self.waterConsumedRepository = waterConsumedRepository
		self.getVolumeFormatUseCase = getVolumeFormatUseCase
	}

	func getWaterConsumedVolumeByPeriod(_ startPeriod: Date, _ endPeriod: Date) -> Observable<WaterWithFormat> {
		wrapWithFormat(
			getWaterConsumedList(startPeriod, endPeriod)
				.map { $0.map { $0.volume }.reduce(0, { $0 + $1 }) }
		)
	}

	private func wrapWithFormat(_ waterInMl: Observable<Int>) -> Observable<WaterWithFormat> {
		return Observable.combineLatest(
			waterInMl,
			getVolumeFormatUseCase.volumeFormat()
		) { volume, format in
			return WaterWithFormat(waterInML: volume, volumeFormat: format)
		}
	}
	
	func getWaterConsumedList(_ startPeriod: Date? = nil, _ endPeriod: Date? = nil) -> Observable<[WaterConsumed]> {
		return waterConsumedRepository.getWaterConsumedList()
			.map {
                $0.filter { item in
                    let inStartPeriod = startPeriod.unwrapLet { $0 < item.consumptionTime } ?? true
                    let inEndPeriod = endPeriod.unwrapLet { item.consumptionTime < $0 } ?? true
                    return inStartPeriod && inEndPeriod
                }
			}
	}
}
