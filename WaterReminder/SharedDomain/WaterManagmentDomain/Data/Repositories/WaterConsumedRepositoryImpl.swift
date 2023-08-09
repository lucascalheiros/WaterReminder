//
//  WaterConsumedRepositoryImpl.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 16/05/23.
//

import RxSwift
import RealmSwift
import RxRealm

internal class WaterConsumedRepositoryImpl: BaseRepository<WaterConsumedObject>, WaterConsumedRepositoryProtocol {

	init() {
		super.init(WaterManagementRealmProvider())
	}

    func getWaterConsumedList() -> Observable<[WaterConsumed]> {
        list()
    }
    
	func registerWaterConsumption(waterVolume: Int, sourceType: WaterSourceType) -> Completable {
        save(
            WaterConsumed(
                volume: waterVolume,
                consumptionTime: Date(),
                waterSourceType: sourceType
            ).toDataObject()
        )
    }
    
}
