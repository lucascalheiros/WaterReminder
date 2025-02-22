//
//  DailyWaterConsumption.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 22/05/23.
//

import Foundation
import GRDB

public struct UserInformation: Codable, Hashable {
    var id: Int64?
    public var weightInGrams: Int?
    public var activityLevel: ActivityLevel?
    public var ambienceTemperatureLevel: AmbienceTemperatureLevel?
    public var date: Date

    public init(
        id: Int64?,
        weightInGrams: Int?,
        activityLevel: ActivityLevel?,
        ambienceTemperatureLevel: AmbienceTemperatureLevel?,
        date: Date
    ) {
        self.id = id
        self.weightInGrams = weightInGrams
        self.activityLevel = activityLevel
        self.ambienceTemperatureLevel = ambienceTemperatureLevel
        self.date = date
    }
}
