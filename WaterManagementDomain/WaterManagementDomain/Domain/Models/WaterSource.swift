//
//  DailyWaterConsumption.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 22/05/23.
//

import UIKit

public struct WaterSource: Hashable, Codable {

    public var id: Int64?
    public var volume: Int
    public var order: Int?
    public var drinkId: Int64

}
