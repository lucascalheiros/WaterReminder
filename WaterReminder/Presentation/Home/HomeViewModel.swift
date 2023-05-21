//
//  HomeViewModel.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 12/05/23.
//

import Foundation
import RxSwift

class HomeViewModel {

    var dailyConsumptionRepository: DailyConsumptionRepository = DailyConsumptionRepositoryMockImpl()
    var waterConsumedRepository: WaterConsumedRepository = WaterConsumedRepositoryMockImpl()
    var waterSourceRepository: WaterSourceRepository = WaterSourceRepositoryMock()
    var waterSourceList = BehaviorSubject<[WaterSource]>(value: [])

    var expectedWaterConsumptionInML = BehaviorSubject<Int>(value: 0)
    var currentWaterConsumedInML = BehaviorSubject<Int>(value: 0)

    lazy var consumedPercentage = {
        Observable.combineLatest(expectedWaterConsumptionInML, currentWaterConsumedInML) { total, current in
            return total == 0 ? 0 : Double(current) / Double(total)
        }.asObservable().observe(on: MainScheduler.instance)
    }()

    lazy var consumedQuantityText = {
        Observable.combineLatest(expectedWaterConsumptionInML, currentWaterConsumedInML) { total, current in
            return "\(current) of \(total)ml"
        }.asObservable().observe(on: MainScheduler.instance)
    }()

    init() {
        Task {
            await updateConsumedVolume()
            await updateDailyConsumptionVolume()
        }
    }

    private func updateDailyConsumptionVolume() async {
        if let expectedVolume = (await dailyConsumptionRepository.lastDailyConsumption())?.expectedVolume {
            expectedWaterConsumptionInML.onNext(expectedVolume)
        }
    }

    private func updateConsumedVolume() async {
        let volume = await waterConsumedRepository.getWaterConsumedList().map { $0.volume }.reduce(0, { $0 + $1 })
        currentWaterConsumedInML.onNext(volume)
    }

    func addWaterVolume(waterContainer: WaterSource) {
        Task {
            await waterConsumedRepository.registerWaterConsumption(waterSource: waterContainer)
            await updateConsumedVolume()
        }
    }

    func updateWaterSourceList() {
        Task {
            let waterSourceList = await waterSourceRepository.getWaterSourceList()
            self.waterSourceList.onNext(waterSourceList)
        }
    }

    func updateWaterSourcePinState(waterSource: WaterSource) {
        Task {
            await waterSourceRepository.updateWaterSourcePinState(
                waterSource: waterSource,
                isPinned: !waterSource.isPinned
            )
            updateWaterSourceList()
        }
    }
}
