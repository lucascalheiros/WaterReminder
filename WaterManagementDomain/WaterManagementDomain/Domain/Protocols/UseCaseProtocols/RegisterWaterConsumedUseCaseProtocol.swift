//
//  RegisterWaterConsumedUseCaseProtocol.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 06/08/23.
//

import RxSwift

public protocol RegisterWaterConsumedUseCaseProtocol {
	func registerWaterConsumption(waterVolume: Int, sourceType: WaterSourceType) -> Completable
}
