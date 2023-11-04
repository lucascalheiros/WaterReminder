//
//  GetConsumedWaterPercentageUseCase.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 03/11/23.
//

import RxSwift

protocol GetConsumedWaterPercentageUseCase {
    func dailyConsumedWaterPercentageWithWaterType(date: Date) -> Observable<[PercentageWithWaterSourceType]>
    func waterPercentageWithTypeByConsumedList(expectedWaterVolume: Float, waterConsumedList: [WaterConsumed]) -> [PercentageWithWaterSourceType]
}
