//
//  RealmProviderProtocol.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 03/06/23.
//

import Foundation
import RealmSwift


protocol RealmProviderProtocol {
	func getInstance() throws -> Realm
}
