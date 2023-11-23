//
//  DailyWaterConsumptionRepositoryImpl.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 21/05/23.
//

import RxSwift
import Core

internal class DailyWaterConsumptionRepositoryImpl: BaseRepository<DailyWaterConsumptionObject>,
											DailyWaterConsumptionRepositoryProtocol {
    init() {
        super.init(WaterManagementRealmProvider())
	}
    
    func getDailyWaterConsumptionList() -> Observable<[DailyWaterConsumption]> {
        list()
    }
    
    func setDailyWaterConsumption(_ expectedConsumption: Int) -> Completable {
        save(DailyWaterConsumption(expectedVolume: expectedConsumption, date: Date()).toDataObject())
    }
}
