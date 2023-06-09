//
//  UserInformationRealmProvider.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 27/05/23.
//

import RealmSwift

struct UserInformationRealmProvider: RealmProviderProtocol {
        
    private let configuration: Realm.Configuration =
        Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
            },
            deleteRealmIfMigrationNeeded: false
        )
    
    func getInstance() throws -> Realm {
        try Realm(configuration: configuration)
    }
    
}
