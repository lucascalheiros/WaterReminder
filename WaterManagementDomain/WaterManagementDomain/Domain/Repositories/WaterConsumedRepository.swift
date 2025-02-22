//
//  WaterSourceRepository.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 16/05/23.
//

import Combine

protocol WaterConsumedRepository {
    func getWaterConsumedList() -> AnyPublisher<[ConsumedCupInfo], any Error>
    func registerWaterConsumption(cup: WaterSource) async throws 
    func registerWaterConsumption(_ volume: Volume, _ drink: Drink) async throws
    func deleteWaterConsumed(_ waterConsumed: WaterConsumed) async throws
}
