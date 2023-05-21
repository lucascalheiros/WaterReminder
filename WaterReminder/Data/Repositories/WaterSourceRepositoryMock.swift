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
        WaterSource(volume: 250, waterSourceType: .water),
        WaterSource(volume: 500, waterSourceType: .water),
        WaterSource(volume: 500, waterSourceType: .coffee),
    ]
    
    func getWaterSourceList() async -> [WaterSource] {
        return self.waterSourceList
    }
    
    func updateWaterSourcePinState(waterSource: WaterSource, isPinned: Bool) async {
        self.waterSourceList.removeAll(where: {
            $0.volume == waterSource.volume && $0.waterSourceType == waterSource.waterSourceType
        })
        let order = (self.waterSourceList.filter { $0.order != Int.max }.map { $0.order }.max() ?? 0) + 1
        self.waterSourceList.append(waterSource.copy(order: isPinned ? order : Int.max, isPinned: isPinned))
        self.waterSourceList.sort(by: { $0.order < $1.order })
    }
    
}
