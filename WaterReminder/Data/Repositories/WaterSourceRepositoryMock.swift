//
//  WaterSourceRepository.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 16/05/23.
//

import Foundation
import RxSwift

class WaterSourceRepositoryMock: WaterSourceRepository {
    
    private var waterSourceList = [
        WaterSource(volume: 250, waterSourceType: .Water, lastTimeUsed: Date()),
        WaterSource(volume: 500, waterSourceType: .Water, lastTimeUsed: Date()),
    ]
    
    func getWaterSourceList() -> Single<[WaterSource]> {
        return Single.create(subscribe: { single in
            single(.success(self.waterSourceList))
            return Disposables.create()
        })
    }
    
    func updateWaterSourceLastUsedTime(waterSource: WaterSource) {
        waterSourceList.removeAll(where: {
            $0.volume == waterSource.volume && $0.waterSourceType == waterSource.waterSourceType
        })
        waterSourceList.append(waterSource.copy(lastTimeUsed: Date()))
        waterSourceList.sort(by: { $0.order == $1.order ? ($0.lastTimeUsed ?? Date.distantPast) > ($1.lastTimeUsed ?? Date.distantPast) : $0.order < $1.order })
    }
    
}
