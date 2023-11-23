//
//  GetConsumedWaterPercentageUseCaseImpl.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 03/11/23.
//

import RxSwift

class GetConsumedWaterPercentageUseCaseImpl: GetConsumedWaterPercentageUseCase {

    private let getWaterConsumedUseCase: GetWaterConsumedUseCaseProtocol
    private let getDailyWaterConsumptionUseCase: GetDailyWaterConsumptionUseCaseProtocol

    private lazy var expectedWaterVolume: Observable<Float> = getDailyWaterConsumptionUseCase.getDailyWaterConsumptionList().map { ($0.last?.expectedVolume ?? 0).toFloat() }

    init(
        getWaterConsumedUseCase: GetWaterConsumedUseCaseProtocol,
        getDailyWaterConsumptionUseCase: GetDailyWaterConsumptionUseCaseProtocol
    ) {
        self.getWaterConsumedUseCase = getWaterConsumedUseCase
        self.getDailyWaterConsumptionUseCase = getDailyWaterConsumptionUseCase
    }

    func dailyConsumedWaterPercentageWithWaterType(date: Date) -> Observable<[PercentageWithWaterSourceType]> {
        let startOfDay = date.startOfDay
        let endOfDay = date.endOfDay
        let waterConsumedListToday: Observable<[WaterConsumed]> = getWaterConsumedUseCase.getWaterConsumedList(startOfDay, endOfDay)
        return Observable.combineLatest(expectedWaterVolume, waterConsumedListToday)
            .map { expectedWaterVolume, waterConsumedList in
                self.waterPercentageWithTypeByConsumedList(expectedWaterVolume: expectedWaterVolume, waterConsumedList: waterConsumedList)
            }
    }

    func waterPercentageWithTypeByConsumedList(expectedWaterVolume: Float, waterConsumedList: [WaterConsumed]) -> [PercentageWithWaterSourceType] {
        let totalConsumedVolume = waterConsumedList.map { $0.volume }.reduce(0, +).toFloat()
        let maxVolume = max(expectedWaterVolume, totalConsumedVolume)
        return Dictionary(grouping: waterConsumedList, by: { $0.waterSourceType }).map { waterSourceType, waterConsumedListByType in
            let volumePerType = waterConsumedListByType.map { $0.volume }.reduce(0, +).toFloat()
            let percentage = volumePerType / maxVolume
            return PercentageWithWaterSourceType(percentage: percentage, waterSourceType: waterSourceType)
        }.sorted(by: { $0.waterSourceType.order < $1.waterSourceType.order })
    }

}
