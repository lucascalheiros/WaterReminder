//
//  ParentControllerProtocol.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 28/05/23.
//

import Foundation

protocol ParentPageControllerProtocol {
	func getProvider() -> PageProviderProtocol
	func onNavigation()
}
