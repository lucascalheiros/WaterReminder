//
//  GetWaterConsumedUseCaseProtocol.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 06/08/23.
//

import RxSwift

public protocol GetWaterConsumedUseCaseProtocol {
	func getWaterConsumedVolumeByPeriod(_ startPeriod: Date, _ endPeriod: Date) -> Observable<WaterWithFormat>
	func getWaterConsumedVolumeToday() -> Observable<WaterWithFormat>
	func getWaterConsumedList(_ startPeriod: Date, _ endPeriod: Date) -> Observable<[WaterConsumed]>
}
