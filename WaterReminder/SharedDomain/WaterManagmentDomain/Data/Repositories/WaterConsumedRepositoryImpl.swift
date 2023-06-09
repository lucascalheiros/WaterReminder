//
//  WaterConsumedRepositoryImpl.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 16/05/23.
//

import RxSwift
import RealmSwift
import RxRealm

class WaterConsumedRepositoryImpl: BaseRepository<WaterConsumedObject>, WaterConsumedRepositoryProtocol {

	init() {
		super.init(WaterManagementRealmProvider())
	}

    func getWaterConsumedList() -> Observable<[WaterConsumed]> {
        list()
    }
    
    func registerWaterConsumption(waterSource: WaterSource) -> Completable {
        save(
            WaterConsumed(
                volume: waterSource.volume,
                consumptionTime: Date(),
                waterSourceType: waterSource.waterSourceType
            ).toDataObject()
        )
    }
    
}
