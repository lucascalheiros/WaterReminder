//
//  DailyWaterConsumption.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 22/05/23.
//

import Foundation

public struct DailyWaterConsumption: Codable {

    public let id: Int64?
    public let expectedVolume: Int
    public let date: Date

    internal init(id: Int64? = nil, expectedVolume: Int, date: Date) {
        self.id = id
        self.expectedVolume = expectedVolume
        self.date = date
    }
}
