//
//  AppContainer.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 03/06/23.
//

import Foundation
import Swinject
import GRDB

func appContainer() -> Container {
	let container = Container()
    container.autoregister(DatabaseQueue.self, initializer: {
        return try! DatabaseQueue(path: getDatabasePath().path)
    })
	return container
}

func getDatabasePath() throws -> URL {
    let fileManager = FileManager.default
    let documentDirectory = try fileManager.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    return documentDirectory.appendingPathComponent("water-reminder.sqlite")
}
