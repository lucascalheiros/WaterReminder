//
//  HomeViewModel.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 12/05/23.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift

class HomeViewModel {
	let manageWaterSourceUseCase: ManageWaterSourceUseCaseProtocol
	let getWaterSourceUseCase: GetWaterSourceUseCaseProtocol
	let registerWaterConsumedUseCase: RegisterWaterConsumedUseCaseProtocol
	let getDailyWaterConsumptionUseCase: GetDailyWaterConsumptionUseCaseProtocol
	let getWaterConsumedUseCase: GetWaterConsumedUseCaseProtocol
	let getVolumeFormatUseCase: GetVolumeFormatUseCaseProtocol
	let homeFlowStepper: HomeFlowStepper

	lazy var waterSourceList = { getWaterSourceUseCase.getWaterSourceList() }()

	lazy var expectedWaterConsumptionInML: Observable<Int> =  {
		getDailyWaterConsumptionUseCase.lastDailyWaterConsumption().map {
			$0?.expectedVolume ?? 0
		}
	}()

	lazy var currentWaterConsumedInML = {
		getWaterConsumedUseCase.getWaterConsumedVolumeToday()
	}()

	lazy var consumedPercentage: Observable<Double> = {
		Observable.combineLatest(expectedWaterConsumptionInML, currentWaterConsumedInML) { total, current in
			return total == 0 ? 0 : Double(current.waterInML) / Double(total)
		}
	}()

	lazy var volumeFormat = {
		getVolumeFormatUseCase.volumeFormat()
	}()

	lazy var volumeFormatText = {
		volumeFormat.map { $0.formatDisplay }
	}()

	lazy var consumedQuantityText = {
		currentWaterConsumedInML.map {
			$0.exhibitionValue()
		}
	}()

	lazy var remainingQuantityText = {
		Observable.combineLatest(expectedWaterConsumptionInML, currentWaterConsumedInML) { total, current in
			let difference = total - current.waterInML
			if difference <= 0 {
				return "You achieved your goal!"
			}
			let remainingWaterWithFormat = WaterWithFormat(waterInML: difference, volumeFormat: current.volumeFormat)
			return "\(remainingWaterWithFormat.exhibitionValueWithFormat()) remaining!"
		}
	}()

	private let disposeBag = DisposeBag()

    lazy var todayConsumedWaterPercentageByWaterType = BehaviorRelay<[PercentageWithWaterSourceType]>(value: [])


	init (
		getDailyWaterConsumptionUseCase: GetDailyWaterConsumptionUseCaseProtocol,
		getWaterConsumedUseCase: GetWaterConsumedUseCaseProtocol,
		registerWaterConsumedUseCase: RegisterWaterConsumedUseCaseProtocol,
		manageWaterSourceUseCase: ManageWaterSourceUseCaseProtocol,
		getWaterSourceUseCase: GetWaterSourceUseCaseProtocol,
		getVolumeFormatUseCase: GetVolumeFormatUseCaseProtocol,
		homeFlowStepper: HomeFlowStepper,
        getConsumedWaterPercentageUseCase: GetConsumedWaterPercentageUseCase
	) {
		self.getDailyWaterConsumptionUseCase = getDailyWaterConsumptionUseCase
		self.getWaterConsumedUseCase = getWaterConsumedUseCase
		self.registerWaterConsumedUseCase = registerWaterConsumedUseCase
		self.manageWaterSourceUseCase = manageWaterSourceUseCase
		self.getWaterSourceUseCase = getWaterSourceUseCase
		self.getVolumeFormatUseCase = getVolumeFormatUseCase
		self.homeFlowStepper = homeFlowStepper

        getConsumedWaterPercentageUseCase.dailyConsumedWaterPercentageWithWaterType(date: Date())
            .bind(to: todayConsumedWaterPercentageByWaterType)
            .disposed(by: disposeBag)

	}

	func addWaterVolume(waterSource: WaterSource) {
		registerWaterConsumedUseCase.registerWaterConsumption(
			waterVolume: waterSource.volume,
			sourceType: waterSource.waterSourceType
		).subscribe().disposed(by: disposeBag)
	}

	func updateWaterSourcePinState(waterSource: WaterSource) {
		manageWaterSourceUseCase.updateWaterSourcePinState(
			waterSource: waterSource,
			pinnedState: !waterSource.isPinned
		).subscribe().disposed(by: disposeBag)
	}

	func showWaterSourceModal() {
		homeFlowStepper.showWaterSourceModal()
	}
}

