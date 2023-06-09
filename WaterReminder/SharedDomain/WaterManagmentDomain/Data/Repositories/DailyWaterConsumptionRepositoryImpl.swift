//
//  DailyWaterConsumptionRepositoryImpl.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 21/05/23.
//

import RxSwift

class DailyWaterConsumptionRepositoryImpl: BaseRepository<DailyWaterConsumptionObject>,
											DailyWaterConsumptionRepositoryProtocol {
    
    let disposeBag = DisposeBag()

    init() {
        super.init(WaterManagementRealmProvider())
		list().safeAsSingle()
			.flatMapCompletable {
				$0.isEmpty ?
				self.setDailyWaterConsumption(2500) : Completable.empty()
			}
			.subscribe().disposed(by: disposeBag)
	}
    
    func getDailyWaterConsumptionList() -> Observable<[DailyWaterConsumption]> {
        list()
    }
    
    func setDailyWaterConsumption(_ expectedConsumption: Int) -> Completable {
        save(DailyWaterConsumption(expectedVolume: expectedConsumption, date: Date()).toDataObject())
    }
    
    func lastDailyWaterConsumption() -> Observable<DailyWaterConsumption?> {
        list().map { $0.max(by: {$0.date > $1.date}) }
    }

}
