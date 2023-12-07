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

	private let getDailyWaterConsumptionUseCase: GetDailyWaterConsumptionUseCaseProtocol
	private let registerDailyWaterConsumptionUseCase: RegisterDailyWaterConsumptionUseCaseProtocol
	private let getVolumeFormatUseCase: GetVolumeFormatUseCaseProtocol
	private let registerVolumeFormatUseCase: RegisterVolumeFormatUseCaseProtocol

	lazy var volumeWithFormat = {
		Observable.combineLatest(
			getDailyWaterConsumptionUseCase.lastDailyWaterConsumption(),
			getVolumeFormatUseCase.volumeFormat()
		) { lastDailyWaterConsumption, volumeFormat in
			WaterWithFormat(waterInML: lastDailyWaterConsumption?.expectedVolume ?? 0, volumeFormat: volumeFormat)
		}
	}()

	init(
		getDailyWaterConsumptionUseCase: GetDailyWaterConsumptionUseCaseProtocol,
		registerDailyWaterConsumptionUseCase: RegisterDailyWaterConsumptionUseCaseProtocol,
		getVolumeFormatUseCase: GetVolumeFormatUseCaseProtocol,
		registerVolumeFormatUseCase: RegisterVolumeFormatUseCaseProtocol
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
}
