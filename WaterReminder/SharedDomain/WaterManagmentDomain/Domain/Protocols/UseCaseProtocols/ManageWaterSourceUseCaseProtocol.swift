//
//  ManageWaterSourceUseCaseProtocol.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 06/08/23.
//

import RxSwift

protocol ManageWaterSourceUseCaseProtocol {
	func createWaterSource(waterVolume: Int, waterSourceType: WaterSourceType) -> Completable
	func updateWaterSourcePinState(waterSource: WaterSource, pinnedState: Bool) -> Completable
}
