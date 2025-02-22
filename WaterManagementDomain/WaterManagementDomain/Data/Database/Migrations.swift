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
        try db.create(table: "dailyWaterConsumption") { t in
            t.autoIncrementedPrimaryKey("id")
            t.column("expectedVolume", .integer).notNull()
            t.column("date", .datetime).notNull()
        }

        try db.create(table: "drink") { t in
            t.autoIncrementedPrimaryKey("id")
            t.column("name", .text).notNull()
            t.column("hydrationFactor", .double).notNull()
            t.column("order", .integer).notNull().defaults(to: Int.max)
            t.column("lightColor", .integer).notNull().defaults(to: 0x0000f4)
            t.column("darkColor", .integer).notNull().defaults(to: 0x26C6DA)
            t.column("isDeleted", .boolean).notNull().defaults(to: false)
        }

        try db.create(table: "waterSource") { t in
            t.autoIncrementedPrimaryKey("id")
            t.column("volume", .integer).notNull()
            t.column("order", .integer)
            t.column("waterSourceType", .text).notNull()
            t.column("isPinned", .text).notNull()
            t.column("drinkId", .integer).references("drink")
            t.column("drinkName", .text).notNull()
            t.column("hydrationFactor", .double).notNull()
            t.column("lightColor", .integer).notNull().defaults(to: 0x0000f4)
            t.column("darkColor", .integer).notNull().defaults(to: 0x26C6DA)
        }

        try db.create(table: "waterConsumed") { t in
            t.autoIncrementedPrimaryKey("id")
            t.column("volume", .integer).notNull()
            t.column("waterSourceType", .text).notNull()
            t.column("consumptionTime", .datetime).notNull()
            t.column("drinkId", .integer).references("drink")
            t.column("drinkName", .text).notNull()
            t.column("hydrationFactor", .double).notNull()
            t.column("lightColor", .integer).notNull().defaults(to: 0x0000f4)
            t.column("darkColor", .integer).notNull().defaults(to: 0x26C6DA)
        }

        try db.execute(literal: """
                       INSERT INTO drink (id, name, hydrationFactor, "order", lightColor, darkColor, isDeleted) VALUES (1, 'Water', 1, 0, 0x0000FF, 0xADD8E6, false);
                       INSERT INTO drink (id, name, hydrationFactor, "order", lightColor, darkColor, isDeleted) VALUES (2, 'Coffee', 1, 1, 0x5C4033, 0xC4A484, false);
                       INSERT INTO drink (id, name, hydrationFactor, "order", lightColor, darkColor, isDeleted) VALUES (3, 'Tea', 1, 2, 0xC18A45, 0xC18A45, false);
                       INSERT INTO drink (id, name, hydrationFactor, "order", lightColor, darkColor, isDeleted) VALUES (4, 'Juice', 1, 3, 0xFF8D00, 0xFF8D00, false);
                       INSERT INTO drink (id, name, hydrationFactor, "order", lightColor, darkColor, isDeleted) VALUES (5, 'Soda', 1, 4, 0xA1DFC0, 0xA1DFC0, false);
                       """)

        try db.execute(literal: """
                       INSERT INTO waterSource (volume, "order", waterSourceType, isPinned, drinkId, drinkName, hydrationFactor, lightColor, darkColor) VALUES (500, 0, 'water', false, 1, 'Water', 1, 0x0000FF, 0xADD8E6);
                       INSERT INTO waterSource (volume, "order", waterSourceType, isPinned, drinkId, drinkName, hydrationFactor, lightColor, darkColor ) VALUES (250, 0, 'water', false, 1, 'Water', 1, 0x0000FF, 0xADD8E6);
                       INSERT INTO waterSource (volume, "order", waterSourceType, isPinned, drinkId, drinkName, hydrationFactor, lightColor, darkColor) VALUES (250, 0, 'coffee', false, 2, 'Coffee', 1, 0x5C4033, 0xC4A484);
                       """)

    }

    migrator.registerMigration("v2") { db in
        try db.alter(table: "waterConsumed") { t in
            t.drop(column: "waterSourceType")
        }
    }

    migrator.registerMigration("v3") { db in
        try db.alter(table: "waterSource") { t in
            t.drop(column: "waterSourceType")
            t.drop(column: "isPinned")
            t.drop(column: "drinkName")
            t.drop(column: "hydrationFactor")
            t.drop(column: "lightColor")
            t.drop(column: "darkColor")
        }
        try db.alter(table: "waterConsumed") { t in
            t.drop(column: "drinkName")
            t.drop(column: "hydrationFactor")
            t.drop(column: "lightColor")
            t.drop(column: "darkColor")
        }
    }

    try migrator.migrate(dbQueue)
}
