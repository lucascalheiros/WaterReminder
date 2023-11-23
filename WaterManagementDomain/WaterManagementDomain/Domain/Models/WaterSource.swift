//
//  DailyWaterConsumption.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 22/05/23.
//

import RealmSwift

public struct WaterSource: Hashable {

    public let id: String?
    public let volume: Int
    public let order: Int?
    public let waterSourceType: WaterSourceType
    public let isPinned: Bool
 
    init(
		id: String? = nil,
		volume: Int,
		order: Int? = nil,
		waterSourceType: WaterSourceType,
		isPinned: Bool = false
	) {
        self.id = id
        self.volume = volume
        self.order = order
        self.waterSourceType = waterSourceType
        self.isPinned = isPinned
    }

    public func copy(
        volume: Int? = nil,
        order: Int? = nil,
        waterSourceType: WaterSourceType? = nil,
        isPinned: Bool? = nil
    ) -> WaterSource {
        return WaterSource(
            id: self.id,
            volume: volume ?? self.volume,
            order: order ?? self.order,
            waterSourceType: waterSourceType ?? self.waterSourceType,
            isPinned: isPinned ?? self.isPinned
        )
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(waterSourceType)
        hasher.combine(volume)
        hasher.combine(order)
        hasher.combine(isPinned)
    }

    public static func == (lhs: WaterSource, rhs: WaterSource) -> Bool {
        return lhs.waterSourceType == rhs.waterSourceType &&
        lhs.isPinned == rhs.isPinned &&
        lhs.order == rhs.order &&
        lhs.volume == rhs.volume &&
        lhs.id == rhs.id
    }

}
