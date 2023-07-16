//
//  DailyWaterConsumption.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 22/05/23.
//

import RealmSwift

struct UserInformation {

    let id: String?
    let weightInGrams: Int?
    let activityLevelInWeekDays: Int?
    let ambienceTemperatureLevel: AmbienceTemperatureLevel?
    let date: Date
    
}
