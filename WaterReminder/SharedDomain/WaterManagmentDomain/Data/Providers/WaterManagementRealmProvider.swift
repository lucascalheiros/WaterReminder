//
//  RealmProvider.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 27/05/23.
//

import RealmSwift

struct WaterManagementRealmProvider: RealmProviderProtocol {
        
    private let configuration: Realm.Configuration =
        Realm.Configuration(
            schemaVersion: 3,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 2 {
                    migration.enumerateObjects(ofType: "WaterSourceObject") { old, new in
                        if old?["order"] as? Int == Int.max {
                            new?["order"] = nil
                        }
                    }
                }
            },
            deleteRealmIfMigrationNeeded: false,
			objectTypes: [DailyWaterConsumptionObject.self, WaterSourceObject.self, WaterSourceObject.self, WaterConsumedObject.self]
        )
    
    func getInstance() throws -> Realm {
        try Realm(configuration: configuration)
    }
    
}
