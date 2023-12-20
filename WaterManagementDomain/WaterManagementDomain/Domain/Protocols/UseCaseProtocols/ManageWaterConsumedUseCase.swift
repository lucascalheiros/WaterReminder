//
//  ManageWaterConsumedUseCase.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 06/08/23.
//

import RxSwift

public protocol ManageWaterConsumedUseCase {
	func registerWaterConsumption(waterVolume: Int, sourceType: WaterSourceType) -> Completable
    func deleteWaterConsumed(_ waterConsumed: WaterConsumed) -> Completable
}
