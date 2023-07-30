//
//  HomeViewModel.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 12/05/23.
//

import Foundation
import RxSwift
import RealmSwift

class HomeViewModel {
	let manageWaterSourceUseCase: ManageWaterSourceUseCase

	let getWaterSourceUseCase: GetWaterSourceUseCase

	let registerWaterConsumedUseCase: RegisterWaterConsumedUseCase

	let getDailyWaterConsumptionUseCase: GetDailyWaterConsumptionUseCase

	let getWaterConsumedUseCase: GetWaterConsumedUseCase
    
	lazy var waterSourceList = { getWaterSourceUseCase.getWaterSourceList() }()
    
    lazy var expectedWaterConsumptionInML: Observable<Int> =  {
		getDailyWaterConsumptionUseCase.lastDailyWaterConsumption().map {
            $0?.expectedVolume ?? 0
        }
    }()
	
    lazy var currentWaterConsumedInML = {
		getWaterConsumedUseCase.getWaterConsumedToday()
    }()
    
    lazy var consumedPercentage: Observable<Double> = {
        Observable.combineLatest(expectedWaterConsumptionInML, currentWaterConsumedInML) { total, current in
            return total == 0 ? 0 : Double(current) / Double(total)
        }.asObservable().observe(on: MainScheduler.instance)
    }()
    
    lazy var consumedQuantityText = {
        Observable.combineLatest(expectedWaterConsumptionInML, currentWaterConsumedInML) { total, current in
            return "\(current)ml"
        }.asObservable().observe(on: MainScheduler.instance)
    }()

	lazy var remainingQuantityText = {
		Observable.combineLatest(expectedWaterConsumptionInML, currentWaterConsumedInML) { total, current in
			let difference = total - current
			if difference <= 0 {
				return "You achieved your goal!"
			}
			return "\(difference)ml remaining!"
		}.asObservable().observe(on: MainScheduler.instance)
	}()
    
    private let disposeBag = DisposeBag()

	init (
		getDailyWaterConsumptionUseCase: GetDailyWaterConsumptionUseCase,
		getWaterConsumedUseCase: GetWaterConsumedUseCase,
		registerWaterConsumedUseCase: RegisterWaterConsumedUseCase,
		manageWaterSourceUseCase: ManageWaterSourceUseCase,
		getWaterSourceUseCase: GetWaterSourceUseCase
	) {
		self.getDailyWaterConsumptionUseCase = getDailyWaterConsumptionUseCase
		self.getWaterConsumedUseCase = getWaterConsumedUseCase
		self.registerWaterConsumedUseCase = registerWaterConsumedUseCase
		self.manageWaterSourceUseCase = manageWaterSourceUseCase
		self.getWaterSourceUseCase = getWaterSourceUseCase
	}
    
    func addWaterVolume(waterSource: WaterSource) {
		registerWaterConsumedUseCase.registerWaterConsumption(waterVolume: waterSource.volume, sourceType: waterSource.waterSourceType)
            .subscribe().disposed(by: DisposeBag())
    }
    
    func updateWaterSourcePinState(waterSource: WaterSource) {
        manageWaterSourceUseCase.updateWaterSourcePinState(
            waterSource: waterSource,
            pinnedState: !waterSource.isPinned
        ).subscribe().disposed(by: disposeBag)
    }
}
