//
//  DailyWaterConsumptionRepository.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 14/05/23.
//

import RxSwift

protocol DailyWaterConsumptionRepository {
    func getDailyWaterConsumptionList() -> Observable<[DailyWaterConsumption]>
    func setDailyWaterConsumption(_ expectedConsumption: Int) -> Completable
}
