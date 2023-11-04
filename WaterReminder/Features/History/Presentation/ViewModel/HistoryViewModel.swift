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
    let getConsumedWaterPercentageUseCase: GetConsumedWaterPercentageUseCase

	lazy var todayWaterConsumedList = {
		let currentDate = Date()
		let startOfDay = currentDate.startOfDay
		let endOfDay = currentDate.endOfDay
		return getWaterConsumedUseCase.getWaterConsumedList(startOfDay, endOfDay)
	}()

	lazy var volumeFormat = BehaviorRelay<VolumeFormat?>(value: nil)

	lazy var todayConsumedVolume = BehaviorRelay<WaterWithFormat?>(value: nil)

    lazy var todayConsumedWaterPercentage: Observable<[PercentageWithWaterSourceType]> = {
        getConsumedWaterPercentageUseCase.todayConsumedWaterPercentageWithWaterType()
    }()
    
	init(
		getWaterConsumedUseCase: GetWaterConsumedUseCaseProtocol,
		getVolumeFormatUseCase: GetVolumeFormatUseCaseProtocol,
		getDailyWaterConsumptionUseCase: GetDailyWaterConsumptionUseCaseProtocol,
        getConsumedWaterPercentageUseCase: GetConsumedWaterPercentageUseCase
	) {
		self.getWaterConsumedUseCase = getWaterConsumedUseCase
		self.getVolumeFormatUseCase = getVolumeFormatUseCase
		self.getDailyWaterConsumptionUseCase = getDailyWaterConsumptionUseCase
        self.getConsumedWaterPercentageUseCase = getConsumedWaterPercentageUseCase
		getVolumeFormatUseCase.volumeFormat()
			.bind(to: volumeFormat).disposed(by: disposeBag)
		getWaterConsumedUseCase.getWaterConsumedVolumeToday()
			.bind(to: todayConsumedVolume).disposed(by: disposeBag)
	}

}
