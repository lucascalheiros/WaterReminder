//
//  WaterSourceRepository.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 16/05/23.
//

import Foundation
import RxSwift

protocol WaterConsumedRepository {
    
    func getWaterConsumedList() async -> [WaterConsumed]
    func registerWaterConsumption(waterSource: WaterSource) async
    
}


