//
//  GetWaterConsumedUseCaseProtocol.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 06/08/23.
//

import RxSwift

protocol GetWaterConsumedUseCaseProtocol {
	func getWaterConsumedByPeriod(startPeriod: Date, endPeriod: Date) -> Observable<WaterWithFormat>
	func getWaterConsumedToday() -> Observable<WaterWithFormat>
}
