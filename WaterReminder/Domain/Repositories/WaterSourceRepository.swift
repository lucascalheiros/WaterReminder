//
//  WaterSourceRepository.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 16/05/23.
//

import Foundation
import RxSwift

protocol WaterSourceRepository {

    func getWaterSourceList() async -> [WaterSource]
    func updateWaterSourcePinState(waterSource: WaterSource, isPinned: Bool) async

}
