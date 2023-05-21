//
//  DailyConsumptionRespositoryMockImpl.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 21/05/23.
//

import Foundation

class DailyConsumptionRepositoryMockImpl: DailyConsumptionRepository {
    
    private var dailyConsumptionList: [DailyConsumption] = [
        DailyConsumption(expectedVolume: 2000, setDate: Date())
    ]
    
    func getDailyConsumptionList() async -> [DailyConsumption] {
        return self.dailyConsumptionList
    }
    
    func setDailyConsumption(expectedConsumption: Int) async {
        self.dailyConsumptionList.append(DailyConsumption(expectedVolume: expectedConsumption, setDate: Date()))
    }
    
    func lastDailyConsumption() async -> DailyConsumption? {
        self.dailyConsumptionList.sorted(by: {$0.setDate > $1.setDate}).first
    }
    
}
