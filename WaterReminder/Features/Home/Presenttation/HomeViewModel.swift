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
    var dailyConsumptionRepository: DailyWaterConsumptionRepositoryProtocol =
	DailyWaterConsumptionRepositoryImpl()
    
	var waterConsumedRepository: WaterConsumedRepositoryProtocol =
	WaterConsumedRepositoryImpl()
    
	var waterSourceRepository: WaterSourceRepositoryProtocol =
	WaterSourceRepositoryImpl()
    
	lazy var waterSourceList = { waterSourceRepository.getWaterSourceList() }()
    
    lazy var expectedWaterConsumptionInML: Observable<Int> =  {
        dailyConsumptionRepository.lastDailyWaterConsumption().map {
            $0?.expectedVolume ?? 0
        }
    }()
	
    lazy var currentWaterConsumedInML = {
		waterConsumedRepository.getWaterConsumedList()
			.map {
				let currentDate = Date()
				let startOfDay = currentDate.startOfDay
				let endOfDay = currentDate.endOfDay
				return $0.filter { startOfDay < $0.consumptionTime && $0.consumptionTime < endOfDay }
					.map { $0.volume }.reduce(0, { $0 + $1 })
			}
    }()
    
    lazy var consumedPercentage: Observable<Double> = {
        Observable.combineLatest(expectedWaterConsumptionInML, currentWaterConsumedInML) { total, current in
            return total == 0 ? 0 : Double(current) / Double(total)
        }.asObservable().observe(on: MainScheduler.instance)
    }()
    
    lazy var consumedQuantityText = {
        Observable.combineLatest(expectedWaterConsumptionInML, currentWaterConsumedInML) { total, current in
            return "\(current) of \(total)ml"
        }.asObservable().observe(on: MainScheduler.instance)
    }()
    
    let disposeBag = DisposeBag()
    
    func addWaterVolume(waterSource: WaterSource) {
        waterConsumedRepository.registerWaterConsumption(waterSource: waterSource)
            .subscribe().disposed(by: DisposeBag())
    }
    
    func updateWaterSourcePinState(waterSource: WaterSource) {
        waterSourceRepository.updateWaterSourcePinState(
            waterSource: waterSource,
            isPinned: !waterSource.isPinned
        ).subscribe().disposed(by: disposeBag)
    }
}
