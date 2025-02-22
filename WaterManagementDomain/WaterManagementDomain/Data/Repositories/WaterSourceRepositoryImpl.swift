//
//  WaterSourceRepositoryImpl.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 16/05/23.
//

import Foundation
import GRDB
import Combine

internal class WaterSourceRepositoryImpl: WaterSourceRepository {

    private let dbQueue: DatabaseQueue

    init(dbQueue: DatabaseQueue) {
        self.dbQueue = dbQueue
    }

    func getWaterSourceList() -> AnyPublisher<[CupInfo], any Error> {
        return ValueObservation.tracking { db in
            try WaterSource
                .including(required: WaterSource.drink)
                .asRequest(of: CupInfo.self)
                .fetchAll(db)
        }
        .publisher(in: dbQueue)
        .eraseToAnyPublisher()
    }

    func createWaterSource(waterSource: WaterSource) async throws {
        try await dbQueue.write { db in
            try waterSource.insert(db)
        }
    }

	func createWaterSource(_ volume: Volume, _ drink: Drink) async throws {
        try await dbQueue.write { db in
            try WaterSource(
                volume: volume.to(.milliliters).value.toInt(),
                drinkId: drink.id!
            ).insert(db)
        }
	}

	func updateWaterSources(waterSources: [WaterSource]) async throws {
        try await dbQueue.write { db in
            try waterSources.forEach{
                try $0.save(db)
            }
        }
	}

    func deleteWaterSource(waterSource: WaterSource) async throws {
        let _ = try await dbQueue.write { db in
            try WaterSource.deleteOne(db, key: waterSource.id)
        }
    }
}

extension WaterSource: TableRecord, FetchableRecord, PersistableRecord {
    static let drink = belongsTo(Drink.self)

}
extension CupInfo: FetchableRecord {

}

