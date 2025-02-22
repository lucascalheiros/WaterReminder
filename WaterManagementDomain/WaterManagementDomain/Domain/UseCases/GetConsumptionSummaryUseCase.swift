//
//  GetConsumptionSummaryUseCase.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 03/11/23.
//

import RxSwift
import Combine

public class GetConsumptionSummaryUseCase {

    private let getWaterConsumedUseCase: GetWaterConsumedUseCase
    private let getDailyWaterConsumptionUseCase: GetDailyWaterConsumptionUseCase

    private lazy var expectedWaterVolume: AnyPublisher<Volume, any Error> = getDailyWaterConsumptionUseCase
        .getDailyWaterConsumptionList()
        .map { Volume(($0.last?.expectedVolume ?? 0), .milliliters) }
        .eraseToAnyPublisher()

    init(
        getWaterConsumedUseCase: GetWaterConsumedUseCase,
        getDailyWaterConsumptionUseCase: GetDailyWaterConsumptionUseCase
    ) {
        self.getWaterConsumedUseCase = getWaterConsumedUseCase
        self.getDailyWaterConsumptionUseCase = getDailyWaterConsumptionUseCase
    }

    public func execute(date: Date) -> AnyPublisher<ConsumptionSummary, any Error> {
        let startOfDay = date.startOfDay
        let endOfDay = date.endOfDay
        let waterConsumedListToday = getWaterConsumedUseCase.getWaterConsumedList(startOfDay, endOfDay)
        return expectedWaterVolume.combineLatest(waterConsumedListToday) { expectedWaterVolume, waterConsumedList in
            ConsumptionSummary(expectedVolume: expectedWaterVolume, consumedCups: waterConsumedList)
        }.eraseToAnyPublisher()
    }

}
