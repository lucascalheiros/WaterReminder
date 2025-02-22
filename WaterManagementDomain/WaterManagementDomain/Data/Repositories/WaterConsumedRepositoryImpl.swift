//
//  WaterConsumedRepositoryImpl.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 16/05/23.
//

import GRDB
import Core
import Combine

internal class WaterConsumedRepositoryImpl: WaterConsumedRepository {

    private let dbQueue: DatabaseQueue

    init(dbQueue: DatabaseQueue) {
        self.dbQueue = dbQueue
    }

    func getWaterConsumedList() -> AnyPublisher<[ConsumedCupInfo], any Error> {
        return ValueObservation.tracking { db in
            try WaterConsumed
                .including(required: WaterConsumed.drink)
                .asRequest(of: ConsumedCupInfo.self)
                .fetchAll(db)
        }
        .publisher(in: dbQueue)
        .eraseToAnyPublisher()
    }
    
    func registerWaterConsumption(cup: WaterSource) async throws {
        try await dbQueue.write { db in
            try WaterConsumed(
                volume: cup.volume,
                consumptionTime: Date(),
                drinkId: cup.drinkId
            ).insert(db)
        }
    }

    func registerWaterConsumption(_ volume: Volume, _ drink: Drink) async throws {
        try await dbQueue.write { db in
            try WaterConsumed(
                volume: volume.to(.milliliters).value.toInt(),
                consumptionTime: Date(),
                drinkId: drink.id!
            ).insert(db)
        }
    }

    func deleteWaterConsumed(_ waterConsumed: WaterConsumed) async throws {
        let _ = try await dbQueue.write { db in
            try WaterConsumed.deleteOne(db, key: waterConsumed.id)
        }
    }
}

extension WaterConsumed: TableRecord, FetchableRecord, PersistableRecord {
    static let drink = belongsTo(Drink.self)
}

extension ConsumedCupInfo: FetchableRecord {

}

