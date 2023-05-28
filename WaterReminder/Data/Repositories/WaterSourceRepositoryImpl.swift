//
//  WaterSourceRepositoryImpl.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 16/05/23.
//

import Foundation
import RxSwift
import RealmSwift
import RxRealm

class WaterSourceRepositoryImpl: BaseRepository<WaterSourceObject>, WaterSourceRepositoryProtocol {
    
    private var waterSourceList = [
        WaterSource(volume: 250, waterSourceType: .water),
        WaterSource(volume: 500, waterSourceType: .water),
        WaterSource(volume: 500, waterSourceType: .coffee)
    ]
    
    
    let disposeBag = DisposeBag()
    override init() {
        super.init()
        list().safeAsSingle()
            .flatMapCompletable {
                $0.isEmpty ?
                self.save(self.waterSourceList.map { $0.toDataObject() }) : Completable.empty()
            }
            .subscribe().disposed(by: disposeBag)
    }

    func getWaterSourceList() -> Observable<[WaterSource]> {
        list().map { $0.sorted(by: { ($0.order ?? Int.max) < ($1.order ?? Int.max) }) }
    }

    func updateWaterSourcePinState(waterSource: WaterSource, isPinned: Bool) -> Completable {
        return list().safeAsSingle()
            .flatMapCompletable {
                let order = isPinned ? ($0.map { $0.order ?? 0 }.max() ?? 0) + 1 : nil
                let waterSource = WaterSourceObject(waterSource: waterSource)
                waterSource.order = order
                waterSource.isPinned = isPinned
                return self.save(waterSource)
            }
    }

}
