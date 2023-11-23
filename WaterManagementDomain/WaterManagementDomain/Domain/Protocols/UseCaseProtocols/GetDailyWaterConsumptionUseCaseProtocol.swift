//
//  GetDailyWaterConsumptionUseCaseProtocol.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 06/08/23.
//

import RxSwift

public protocol GetDailyWaterConsumptionUseCaseProtocol {
	func getDailyWaterConsumptionList() -> Observable<[DailyWaterConsumption]>
	func lastDailyWaterConsumption() -> Observable<DailyWaterConsumption?>
}
