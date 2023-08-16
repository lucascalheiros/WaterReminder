//
//  HistoryViewModel.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 12/08/23.
//

import RxRelay
import RxSwift

class HistoryViewModel {
	let disposeBag = DisposeBag()
	let getWaterConsumedUseCase: GetWaterConsumedUseCaseProtocol
	let getVolumeFormatUseCase: GetVolumeFormatUseCaseProtocol
	let getDailyWaterConsumptionUseCase: GetDailyWaterConsumptionUseCaseProtocol

	lazy var todayWaterConsumedList = {
		let currentDate = Date()
		let startOfDay = currentDate.startOfDay
		let endOfDay = currentDate.endOfDay
		return getWaterConsumedUseCase.getWaterConsumedList(startOfDay, endOfDay)
	}()

	lazy var volumeFormat = BehaviorRelay<VolumeFormat?>(value: nil)

	lazy var todayConsumedVolume = BehaviorRelay<WaterWithFormat?>(value: nil)

	lazy var todayConsumedWaterPercentage: Observable<Float> = Observable.combineLatest(todayConsumedVolume, getDailyWaterConsumptionUseCase.lastDailyWaterConsumption()) { todayVolume, waterGoal in
		if let expectedVolume = waterGoal?.expectedVolume, let todayVolume = todayVolume?.waterInML {
			return Float(todayVolume) / Float(expectedVolume)
		}
		return 0
	}

	init(
		getWaterConsumedUseCase: GetWaterConsumedUseCaseProtocol,
		getVolumeFormatUseCase: GetVolumeFormatUseCaseProtocol,
		getDailyWaterConsumptionUseCase: GetDailyWaterConsumptionUseCaseProtocol
	) {
		self.getWaterConsumedUseCase = getWaterConsumedUseCase
		self.getVolumeFormatUseCase = getVolumeFormatUseCase
		self.getDailyWaterConsumptionUseCase = getDailyWaterConsumptionUseCase
		getVolumeFormatUseCase.volumeFormat()
			.bind(to: volumeFormat).disposed(by: disposeBag)
		getWaterConsumedUseCase.getWaterConsumedVolumeToday()
			.bind(to: todayConsumedVolume).disposed(by: disposeBag)
	}

}
