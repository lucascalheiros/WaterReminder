//
//  WaterSourceRepository.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 16/05/23.
//

import Foundation
import RxSwift

protocol WaterConsumedRepository {
    func getWaterConsumedList() -> Observable<[WaterConsumed]>
    func registerWaterConsumption(waterVolume: Int, sourceType: WaterSourceType) -> Completable
    func deleteWaterConsumed(_ waterConsumed: WaterConsumed) -> Completable
}
