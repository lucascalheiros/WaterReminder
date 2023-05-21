//
//  WaterContainer.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 07/05/23.
//

import Foundation

struct WaterSource {
    
    let volume: Int
    let order: Int
    let waterSourceType: WaterSourceType
    let lastTimeUsed: Date?
    
    internal init(volume: Int = Int.random(in: 150...300)) {
        self.volume = volume
        self.order = Int.max
        self.waterSourceType = .Water
        self.lastTimeUsed = nil
    }
    
    internal init(volume: Int, order: Int = Int.max, waterSourceType: WaterSourceType, lastTimeUsed: Date? = nil) {
        self.volume = volume
        self.order = order
        self.waterSourceType = waterSourceType
        self.lastTimeUsed = lastTimeUsed
    }
    
    func copy(volume: Int? = nil, order: Int? = nil, waterSourceType: WaterSourceType? = nil, lastTimeUsed: Date? = nil) -> WaterSource {
        return WaterSource(
            volume: volume ?? self.volume,
            order: order ?? self.order,
            waterSourceType: waterSourceType ?? self.waterSourceType,
            lastTimeUsed: lastTimeUsed ?? self.lastTimeUsed
        )
    }
    
}


extension WaterSource {
    static func getSample(number: Int) -> [WaterSource] {
        return (0...number).map({value in WaterSource()})
    }
}
