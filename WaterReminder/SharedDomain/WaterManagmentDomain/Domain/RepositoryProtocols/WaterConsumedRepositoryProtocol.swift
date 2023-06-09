//
//  WaterSourceRepository.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 16/05/23.
//

import Foundation
import RxSwift

protocol WaterConsumedRepositoryProtocol {

    func getWaterConsumedList() -> Observable<[WaterConsumed]>
    func registerWaterConsumption(waterSource: WaterSource) -> Completable

}
