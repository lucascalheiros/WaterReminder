//
//  GetConsumedWaterPercentageUseCaseImpl.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 03/11/23.
//

import RxSwift

class GetConsumedWaterPercentageUseCaseImpl: GetConsumedWaterPercentageUseCase {

    let getWaterConsumedUseCase: GetWaterConsumedUseCaseProtocol
    let getDailyWaterConsumptionUseCase: GetDailyWaterConsumptionUseCaseProtocol

    init(
        getWaterConsumedUseCase: GetWaterConsumedUseCaseProtocol,
        getDailyWaterConsumptionUseCase: GetDailyWaterConsumptionUseCaseProtocol
    ) {
        self.getWaterConsumedUseCase = getWaterConsumedUseCase
        self.getDailyWaterConsumptionUseCase = getDailyWaterConsumptionUseCase
    }

    func todayConsumedWaterPercentageWithWaterType() -> Observable<[PercentageWithWaterSourceType]> {
        let currentDate = Date()
        let startOfDay = currentDate.startOfDay
        let endOfDay = currentDate.endOfDay
        let expectedWaterVolume: Observable<Float> = getDailyWaterConsumptionUseCase.getDailyWaterConsumptionList().map { ($0.last?.expectedVolume ?? 0).toFloat() }
        let waterConsumedListToday: Observable<[WaterConsumed]> = getWaterConsumedUseCase.getWaterConsumedList(startOfDay, endOfDay)
        return Observable.combineLatest(expectedWaterVolume, waterConsumedListToday)
            .map { expectedWaterVolume, waterConsumedList in
                var totalVolume: Float = 0
                var volumeToWaterSourceType: [WaterSourceType:Float] = [:]
                for waterConsumed in waterConsumedList {
                    let volume = waterConsumed.volume.toFloat()
                    totalVolume += volume
                    var volumeByType = volumeToWaterSourceType[waterConsumed.waterSourceType] ?? 0
                    volumeByType += volume
                    volumeToWaterSourceType[waterConsumed.waterSourceType] = volumeByType
                }

                return volumeToWaterSourceType.map { key, value in
                    let maxValue = max(expectedWaterVolume, totalVolume)
                    let percentage: Float = (Float(value) / maxValue)
                    return PercentageWithWaterSourceType(percentage: percentage, waterSourceType: key)
                }.sorted(by: { $0.waterSourceType.order < $1.waterSourceType.order })
            }
    }

}
