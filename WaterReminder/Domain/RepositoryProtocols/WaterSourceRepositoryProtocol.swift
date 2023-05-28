//
//  WaterSourceRepository.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 16/05/23.
//

import Foundation
import RxSwift

protocol WaterSourceRepositoryProtocol {

    func getWaterSourceList() -> Observable<[WaterSource]>
    func updateWaterSourcePinState(waterSource: WaterSource, isPinned: Bool) -> Completable

}
