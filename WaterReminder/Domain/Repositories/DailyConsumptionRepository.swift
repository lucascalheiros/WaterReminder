//
//  DailyConsumptionRepository.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 14/05/23.
//

import Foundation

protocol DailyConsumptionRepository {
    
    func getDailyConsumptionList() async -> [DailyConsumption]
    func setDailyConsumption(expectedConsumption: Int) async
    func lastDailyConsumption() async -> DailyConsumption?
    
}
