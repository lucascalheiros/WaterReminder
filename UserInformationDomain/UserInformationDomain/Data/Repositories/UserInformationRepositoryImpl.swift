//
//  UserInformationRepositoryImpl.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 04/06/23.
//

import Foundation
import Combine
import Core
import GRDB

class UserInformationRepostoryImpl: UserInformationRepository {

    let dbQueue: DatabaseQueue

    init(_ dbQueue: DatabaseQueue) {
        self.dbQueue = dbQueue
    }

    func getUserInformationList() -> AnyPublisher<[UserInformation], any Error> {
        return ValueObservation.tracking { db in
            try UserInformation.fetchAll(db)
        }
        .publisher(in: dbQueue)
        .eraseToAnyPublisher()
	}

    func saveUserInformation(_ userInformation: UserInformation) async throws  {
        try await dbQueue.write { db in
            try userInformation.save(db)
        }
	}
}


extension UserInformation: FetchableRecord, PersistableRecord {

}
