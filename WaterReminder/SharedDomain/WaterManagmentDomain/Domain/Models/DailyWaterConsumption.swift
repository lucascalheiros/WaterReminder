//
//  DailyWaterConsumption.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 22/05/23.
//

import RealmSwift

struct DailyWaterConsumption {
   
    let id: String?
    let expectedVolume: Int
    let date: Date
    
    internal init(id: String? = nil, expectedVolume: Int, date: Date) {
        self.id = id
        self.expectedVolume = expectedVolume
        self.date = date
    }
}
