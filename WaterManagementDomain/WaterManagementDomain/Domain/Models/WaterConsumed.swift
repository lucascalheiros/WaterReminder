//
//  DailyWaterConsumption.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 22/05/23.
//

import RealmSwift

public struct WaterConsumed: Hashable {

    public let id: String?
    public let volume: Int
    public let consumptionTime: Date
    public let waterSourceType: WaterSourceType
    
    internal init(id: String? = nil, volume: Int, consumptionTime: Date, waterSourceType: WaterSourceType) {
        self.id = id
        self.volume = volume
        self.consumptionTime = consumptionTime
        self.waterSourceType = waterSourceType
    }
    
}
