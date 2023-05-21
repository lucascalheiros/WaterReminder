//
//  HomeViewModel.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 12/05/23.
//

import Foundation
import RxSwift

class HomeViewModel {
    
    var waterSourceRepository: WaterSourceRepository = WaterSourceRepositoryMock()
    var waterSourceList = BehaviorSubject<[WaterSource]>(value: [])
    
    
    var expectedWaterConsumptionInML = BehaviorSubject<Int>(value: 2000)
    var currentWaterConsumedInML = BehaviorSubject<Int>(value: 500)
    lazy var consumedPercentage = {
        Observable.combineLatest(expectedWaterConsumptionInML, currentWaterConsumedInML) { total, current in
            return Double(current) / Double(total)
        }
    }()
    
    lazy var consumedQuantityText = {
        Observable.combineLatest(expectedWaterConsumptionInML, currentWaterConsumedInML) { total, current in
            return "\(current) of \(total)ml"
        }
    }()
    
    func addWaterVolume(waterContainer: WaterSource) {
        do {
            try currentWaterConsumedInML.onNext(currentWaterConsumedInML.value() + waterContainer.volume)
            registerWaterConsumption(waterSource: waterContainer)
            print("success")
            
        } catch {
            print("failure")
            
        }
    }
    
    func updateWaterSourceList() {
        waterSourceRepository.getWaterSourceList().subscribe(onSuccess: { res in
            self.waterSourceList.onNext(res)
        })
    }
    
    func registerWaterConsumption(waterSource: WaterSource) {
        waterSourceRepository.updateWaterSourceLastUsedTime(waterSource: waterSource)
        updateWaterSourceList()
    }
}
