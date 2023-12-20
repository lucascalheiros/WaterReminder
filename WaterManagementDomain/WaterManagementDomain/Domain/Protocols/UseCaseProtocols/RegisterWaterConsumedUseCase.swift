//
//  RegisterWaterConsumedUseCase.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 06/08/23.
//

import RxSwift

public protocol RegisterWaterConsumedUseCase {
	func registerWaterConsumption(waterVolume: Int, sourceType: WaterSourceType) -> Completable
}
