//
//  WaterSourceRepository.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 16/05/23.
//

import Combine

protocol WaterSourceRepository {
    func getWaterSourceList() -> AnyPublisher<[CupInfo], any Error>
	func createWaterSource(waterSource: WaterSource) async throws
    func createWaterSource(_ volume: Volume, _ drink: Drink) async throws 
    func updateWaterSources(waterSources: [WaterSource]) async throws
    func deleteWaterSource(waterSource: WaterSource) async throws
}
