//
//  Database.swift
//  WaterManagementDomain
//
//  Created by Lucas Calheiros on 09/02/25.
//

import Foundation
import GRDB

let databaseFile = "water-management.sqlite"

func getDatabase(_ databaseFile: String) throws -> DatabaseQueue {
    let fileManager = FileManager.default
    let documentDirectory = try fileManager.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    let path = documentDirectory.appendingPathComponent(databaseFile).path
    let db = try DatabaseQueue(path: path)
    try applyMigration(db)
    return db
}
