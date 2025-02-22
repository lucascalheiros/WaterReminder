//
//  DrinkRepositoryImpl.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 16/05/23.
//

import Foundation
import GRDB
import Combine

internal class DrinkRepositoryImpl: DrinkRepository {

    private let dbQueue: DatabaseQueue

    init(dbQueue: DatabaseQueue) {
        self.dbQueue = dbQueue
    }

    func getDrinkList() -> AnyPublisher<[Drink], any Error> {
        return ValueObservation.tracking { db in
            try Drink.fetchAll(db)
        }
        .publisher(in: dbQueue)
        .map { $0.filter { !$0.isDeleted } }
        .eraseToAnyPublisher()
    }

    func createDrink(_ drink: Drink) async throws {
        try await dbQueue.write { db in
            try drink.insert(db)
        }
    }

    func deleteDrink(_ drink: Drink) async throws {
        try await dbQueue.write { db in
            var drink = drink
            drink.isDeleted = true
            try drink.save(db)
        }
    }
}

extension Drink: TableRecord, FetchableRecord, PersistableRecord {

}
