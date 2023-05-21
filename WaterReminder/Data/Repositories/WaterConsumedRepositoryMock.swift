//
//  WaterSourceRepository.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 16/05/23.
//

import Foundation
import RxSwift

class WaterConsumedRepositoryMockImpl: WaterConsumedRepository {
    
    func getWaterConsumedList() -> Single<[WaterConsumed]> {
        return Single.create(subscribe: {
            $0(.success([]))
            return Disposables.create()
        })
    }
    
}
