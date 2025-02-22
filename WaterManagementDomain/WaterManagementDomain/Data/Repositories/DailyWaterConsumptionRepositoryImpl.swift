//
//  DailyWaterConsumptionRepositoryImpl.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 21/05/23.
//

import GRDB
import Combine

internal class DailyWaterConsumptionRepositoryImpl:	DailyWaterConsumptionRepository {

    private let dbQueue: DatabaseQueue

    init(dbQueue: DatabaseQueue) {
        self.dbQueue = dbQueue
    }

    func getDailyWaterConsumptionList() -> AnyPublisher<[DailyWaterConsumption], any Error> {
        return ValueObservation.tracking { db in
            try DailyWaterConsumption.fetchAll(db)
        }
        .publisher(in: dbQueue)
        .eraseToAnyPublisher()
    }

    func setDailyWaterConsumption(_ volume: Volume) async throws {
        try await dbQueue.write { db in
            try DailyWaterConsumption(expectedVolume: Int(volume.value), date: Date()).insert(db)
        }
    }
}

extension DailyWaterConsumption: FetchableRecord, PersistableRecord {

}
