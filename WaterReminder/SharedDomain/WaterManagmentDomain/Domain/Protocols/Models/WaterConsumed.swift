//
//  DailyWaterConsumption.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 22/05/23.
//

import RealmSwift

struct WaterConsumed: Hashable {

    let id: String?
    let volume: Int
    let consumptionTime: Date
    let waterSourceType: WaterSourceType
    
    internal init(id: String? = nil, volume: Int, consumptionTime: Date, waterSourceType: WaterSourceType) {
        self.id = id
        self.volume = volume
        self.consumptionTime = consumptionTime
        self.waterSourceType = waterSourceType
    }
    
}
