//
//  DailyWaterConsumption.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 22/05/23.
//

import RealmSwift
import Core

internal class DailyWaterConsumptionObject: BaseObject {
    
    typealias DomainType = DailyWaterConsumption
    
    @Persisted var expectedVolume: Int = 0
    @Persisted var date: Date = Date()
    
    convenience init(dailyWaterConsumption: DailyWaterConsumption) {
        self.init()
        self.id = dailyWaterConsumption.id
        self.expectedVolume = dailyWaterConsumption.expectedVolume
        self.date = dailyWaterConsumption.date
    }
    
    func toDomainModel() -> DailyWaterConsumption {
        return DailyWaterConsumption(id: id, expectedVolume: expectedVolume, date: date)
    }
    
}

extension DailyWaterConsumption {
    func toDataObject() -> DailyWaterConsumptionObject {
        DailyWaterConsumptionObject(dailyWaterConsumption: self)
    }
}
