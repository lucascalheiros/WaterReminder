//
//  DailyWaterConsumption.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 22/05/23.
//

import RealmSwift

public struct DailyWaterConsumption {

    public let id: String?
    public let expectedVolume: Int
    public let date: Date

    internal init(id: String? = nil, expectedVolume: Int, date: Date) {
        self.id = id
        self.expectedVolume = expectedVolume
        self.date = date
    }
}
