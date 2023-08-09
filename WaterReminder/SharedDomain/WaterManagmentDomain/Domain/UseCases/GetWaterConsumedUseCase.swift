//
//  GetWaterConsumedUseCase.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 09/07/23.
//

import RxSwift

internal class GetWaterConsumedUseCase: GetWaterConsumedUseCaseProtocol {
	let waterConsumedRepository: WaterConsumedRepositoryProtocol
	let getVolumeFormatUseCase: GetVolumeFormatUseCaseProtocol

	init(
		waterConsumedRepository: WaterConsumedRepositoryProtocol,
		getVolumeFormatUseCase: GetVolumeFormatUseCaseProtocol
	) {
		self.waterConsumedRepository = waterConsumedRepository
		self.getVolumeFormatUseCase = getVolumeFormatUseCase
	}

	func getWaterConsumedByPeriod(startPeriod: Date, endPeriod: Date) -> Observable<WaterWithFormat> {
		wrapWithFormat(waterConsumedRepository.getWaterConsumedList()
			.map {
				$0.filter { startPeriod < $0.consumptionTime && $0.consumptionTime < endPeriod }
					.map { $0.volume }.reduce(0, { $0 + $1 })
			})
	}

	func getWaterConsumedToday() -> Observable<WaterWithFormat> {
		let currentDate = Date()
		let startOfDay = currentDate.startOfDay
		let endOfDay = currentDate.endOfDay
		return getWaterConsumedByPeriod(startPeriod: startOfDay, endPeriod: endOfDay)
	}

	private func wrapWithFormat(_ waterInMl: Observable<Int>) -> Observable<WaterWithFormat> {
		return Observable.combineLatest(
			waterInMl,
			getVolumeFormatUseCase.volumeFormat()
		) { volume, format in
			return WaterWithFormat(waterInML: volume, volumeFormat: format)
		}
	}
}
