//
//  ConsumedCupInfo.swift
//  WaterManagementDomain
//
//  Created by Lucas Calheiros on 21/02/25.
//

import GRDB

public struct ConsumedCupInfo: Decodable, Hashable {
    public var consumedCup: WaterConsumed
    public var drink: Drink
    public var hydrationVolume: Double {
        consumedCup.volume.toDouble() * drink.hydrationFactor
    }
}
