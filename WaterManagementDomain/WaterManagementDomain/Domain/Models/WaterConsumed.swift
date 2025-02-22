//
//  DailyWaterConsumption.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 22/05/23.
//

import Foundation
import UIKit

public struct WaterConsumed: Hashable, Codable {

    public var id: Int64?
    public var volume: Int
    public var consumptionTime: Date
    public var drinkId: Int64
}


