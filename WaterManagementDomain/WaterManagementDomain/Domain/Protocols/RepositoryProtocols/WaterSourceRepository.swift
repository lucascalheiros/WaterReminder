//
//  WaterSourceRepository.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 16/05/23.
//

import Foundation
import RxSwift

protocol WaterSourceRepository {
    func getWaterSourceList() -> Observable<[WaterSource]>
	func createWaterSource(waterSource: WaterSource) -> Completable
    func updateWaterSourcePinState(waterSource: WaterSource, isPinned: Bool) -> Completable
	func updateWaterSources(waterSources: [WaterSource]) -> Completable
    func deleteWaterSource(waterSource: WaterSource) -> Completable
}
