//
//  RegisterDailyWaterConsumptionUseCaseProtocol.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 06/08/23.
//

import RxSwift

protocol RegisterDailyWaterConsumptionUseCaseProtocol {
	func registerDailyWaterConsumption(waterValue: Int) -> Completable
}
