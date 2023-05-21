//
//  WaterSourceRepository.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 16/05/23.
//

import Foundation
import RxSwift

class WaterConsumedRepositoryMockImpl: WaterConsumedRepository {
    
    private var waterConsumedList: [WaterConsumed] = []
    
    func getWaterConsumedList() async -> [WaterConsumed] {
        return waterConsumedList
    }
    
    func registerWaterConsumption(waterSource: WaterSource) async {
        waterConsumedList.append(
            WaterConsumed(
                volume: waterSource.volume,
                waterSourceType: waterSource.waterSourceType,
                consumptionTime: Date()
            )
        )
    }
    
}
