//
//  DailyWaterSelectorDelegate.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 03/08/23.
//

import RxSwift
import RxCocoa
import WaterManagementDomain

class DailyWaterSelectorDelegate {
	let disposeBag = DisposeBag()

	private let getDailyWaterConsumptionUseCase: GetDailyWaterConsumptionUseCase
	private let registerDailyWaterConsumptionUseCase: RegisterDailyWaterConsumptionUseCase
	private let getVolumeFormatUseCase: GetVolumeFormatUseCase
	private let registerVolumeFormatUseCase: RegisterVolumeFormatUseCase

	lazy var volumeWithFormat = {
		Observable.combineLatest(
			getDailyWaterConsumptionUseCase.lastDailyWaterConsumption(),
            volumeFormat
		) { lastDailyWaterConsumption, volumeFormat in
			WaterWithFormat(waterInML: lastDailyWaterConsumption?.expectedVolume ?? 0, volumeFormat: volumeFormat)
		}
	}()

    lazy var volumeFormat = getVolumeFormatUseCase.volumeFormat()

	init(
		getDailyWaterConsumptionUseCase: GetDailyWaterConsumptionUseCase,
		registerDailyWaterConsumptionUseCase: RegisterDailyWaterConsumptionUseCase,
		getVolumeFormatUseCase: GetVolumeFormatUseCase,
		registerVolumeFormatUseCase: RegisterVolumeFormatUseCase
	) {
		self.getDailyWaterConsumptionUseCase = getDailyWaterConsumptionUseCase
		self.registerDailyWaterConsumptionUseCase = registerDailyWaterConsumptionUseCase
		self.getVolumeFormatUseCase = getVolumeFormatUseCase
		self.registerVolumeFormatUseCase = registerVolumeFormatUseCase
	}

	func setVolumeAndFormat(_ volumeInFormat: Float, _ format: VolumeFormat) {
		let volumeMetric = Int(format.toMetric(volumeInFormat))
		registerDailyWaterConsumptionUseCase.registerDailyWaterConsumption(waterValue: volumeMetric)
			.subscribe().disposed(by: disposeBag)
		registerVolumeFormatUseCase.setVolumeFormat(format)
	}

    func setFormat(_ format: VolumeFormat) {
        registerVolumeFormatUseCase.setVolumeFormat(format)
    }
}
