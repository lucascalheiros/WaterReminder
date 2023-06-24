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
            schemaVersion: 3,
            migrationBlock: { migration, oldSchemaVersion in
				if oldSchemaVersion < 3 {
					migration.enumerateObjects(ofType: "UserInformationObject") { old, new in
						if old?["ambienceTemperatureLevel"] as? Int == Int.max {
							new?["ambienceTemperatureLevel"] = nil
						}
					}
				}
            },
            deleteRealmIfMigrationNeeded: false,
			objectTypes: [UserInformationObject.self, AmbienceTemperatureRangeEmbeddedObject.self]
        )
    
    func getInstance() throws -> Realm {
        try Realm(configuration: configuration)
    }
    
}
