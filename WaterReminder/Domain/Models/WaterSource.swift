//
//  WaterContainer.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 07/05/23.
//

import Foundation

class WaterSource: Hashable {

    let volume: Int
    let order: Int
    let waterSourceType: WaterSourceType
    let isPinned: Bool

    internal init(volume: Int = Int.random(in: 150...300)) {
        self.volume = volume
        self.order = Int.max
        self.waterSourceType = .water
        self.isPinned = false
    }

    internal init(volume: Int, order: Int = Int.max, waterSourceType: WaterSourceType, isPinned: Bool = false) {
        self.volume = volume
        self.order = order
        self.waterSourceType = waterSourceType
        self.isPinned = isPinned
    }

    func copy(volume: Int? = nil, order: Int? = nil, waterSourceType: WaterSourceType? = nil, isPinned: Bool? = nil) -> WaterSource {
        return WaterSource(
            volume: volume ?? self.volume,
            order: order ?? self.order,
            waterSourceType: waterSourceType ?? self.waterSourceType,
            isPinned: isPinned ?? self.isPinned
        )
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(waterSourceType)
        hasher.combine(volume)
        hasher.combine(order)
        hasher.combine(isPinned)
    }

    static func == (lhs: WaterSource, rhs: WaterSource) -> Bool {
        return lhs.waterSourceType == rhs.waterSourceType &&
        lhs.isPinned == rhs.isPinned &&
        lhs.order == rhs.order &&
        lhs.volume == rhs.volume
    }

}

extension WaterSource {
    static func getSample(number: Int) -> [WaterSource] {
        return (0...number).map({_ in WaterSource()})
    }
}
