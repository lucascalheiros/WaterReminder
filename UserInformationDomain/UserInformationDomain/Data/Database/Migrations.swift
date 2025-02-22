//
//  Migrations.swift
//  WaterManagementDomain
//
//  Created by Lucas Calheiros on 09/02/25.
//

import GRDB

func applyMigration(_ dbQueue: DatabaseQueue) throws {
    var migrator = DatabaseMigrator()

    migrator.registerMigration("v1") { db in
        try db.create(table: "userInformation") { t in
            t.autoIncrementedPrimaryKey("id")
            t.column("weightInGrams", .integer)
            t.column("activityLevel", .text)
            t.column("ambienceTemperatureLevel", .text)
            t.column("date", .datetime).notNull()
        }
    }

    try migrator.migrate(dbQueue)
}
