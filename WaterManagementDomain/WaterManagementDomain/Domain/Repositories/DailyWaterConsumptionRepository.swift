//
//  DailyWaterConsumptionRepository.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 14/05/23.
//

import Combine

protocol DailyWaterConsumptionRepository {
    func getDailyWaterConsumptionList() -> AnyPublisher<[DailyWaterConsumption], any Error>
    func setDailyWaterConsumption(_ volume: Volume) async throws
}
