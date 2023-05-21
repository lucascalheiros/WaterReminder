//
//  WaterSourceRepository.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 16/05/23.
//

import Foundation
import RxSwift

protocol WaterSourceRepository {
    
    func getWaterSourceList() -> Single<[WaterSource]>
    func updateWaterSourceLastUsedTime(waterSource: WaterSource)
    
}
