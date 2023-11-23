//
//  RegisterDailyWaterConsumptionUseCaseProtocol.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 06/08/23.
//

import RxSwift

public protocol RegisterDailyWaterConsumptionUseCaseProtocol {
	func registerDailyWaterConsumption(waterValue: Int) -> Completable
}
