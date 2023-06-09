//
//  ParentControllerProtocol.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 28/05/23.
//

import Foundation
import UIKit

protocol ParentPageControllerProtocol {
	func getProvider() -> PageProviderProtocol
	func skipToLastPage()
}
