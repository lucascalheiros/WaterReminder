//
//  DailyWaterConsumption.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 22/05/23.
//

import RealmSwift

public struct UserInformation {
    let id: String?
    let weightInGrams: Int?
    let activityLevelInWeekDays: Int?
    let ambienceTemperatureLevel: AmbienceTemperatureLevel?
    let date: Date

    public init(id: String?, weightInGrams: Int?, activityLevelInWeekDays: Int?, ambienceTemperatureLevel: AmbienceTemperatureLevel?, date: Date) {
        self.id = id
        self.weightInGrams = weightInGrams
        self.activityLevelInWeekDays = activityLevelInWeekDays
        self.ambienceTemperatureLevel = ambienceTemperatureLevel
        self.date = date
    }
}
