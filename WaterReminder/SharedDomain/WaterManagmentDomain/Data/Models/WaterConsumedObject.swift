//
//  DailyWaterConsumption.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 22/05/23.
//

import RealmSwift

class WaterConsumedObject: BaseObject {
    
    typealias DomainType = WaterConsumed

    @Persisted var volume: Int = 0
    @Persisted var waterSourceTypeRaw: String = WaterSourceType.water.rawValue
    @Persisted var consumptionTime: Date = Date()
    
    var waterSourceType: WaterSourceType {
        get {
            return WaterSourceType(rawValue: waterSourceTypeRaw)!
        }
        set {
            waterSourceTypeRaw = newValue.rawValue
        }
      }
    
    convenience init(
        waterConsumed: WaterConsumed
    ) {
        self.init()
        self.id = waterConsumed.id
        self.volume = waterConsumed.volume
        self.waterSourceType = waterConsumed.waterSourceType
        self.consumptionTime = waterConsumed.consumptionTime
    }
    
    func toDomainModel() -> WaterConsumed {
        return WaterConsumed(
			id: id,
			volume: volume,
			consumptionTime: consumptionTime,
			waterSourceType: waterSourceType
		)
    }
    
}

extension WaterConsumed {
    func toDataObject() -> WaterConsumedObject {
        WaterConsumedObject(waterConsumed: self)
    }
}
