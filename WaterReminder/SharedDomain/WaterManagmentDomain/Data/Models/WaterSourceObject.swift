//
//  DailyWaterConsumption.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 22/05/23.
//

import RealmSwift

class WaterSourceObject: BaseObject {
    
    typealias DomainType = WaterSource

    @Persisted var volume: Int = 0
	@Persisted var order: Int?
	@Persisted var waterSourceTypeRaw: String = WaterSourceType.water.rawValue
	@Persisted var isPinned: Bool = false
	
	var waterSourceType: WaterSourceType {
		get {
			return WaterSourceType(rawValue: waterSourceTypeRaw)!
		}
		set {
			waterSourceTypeRaw = newValue.rawValue
		}
      }

    convenience init(
        waterSource: WaterSource
    ) {
        self.init()
		self.id = waterSource.id
		self.volume = waterSource.volume
        self.order = waterSource.order
        self.waterSourceType = waterSource.waterSourceType
        self.isPinned = waterSource.isPinned
    }

    func toDomainModel() -> WaterSource {
		return WaterSource(
			id: id,
			volume: volume,
			order: order,
			waterSourceType: waterSourceType,
			isPinned: isPinned
		)
    }
    
}

extension WaterSource {
    func toDataObject() -> WaterSourceObject {
        WaterSourceObject(waterSource: self)
    }
}
