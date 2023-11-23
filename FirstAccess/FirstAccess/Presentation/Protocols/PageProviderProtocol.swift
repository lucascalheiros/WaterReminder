//
//  PageProviderProtocol.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 28/05/23.
//

import Foundation
import UIKit

protocol PageProviderProtocol {
	var count: Int { get }
	func instanceFor(index: Int) -> UIViewController?
	func indexFor(viewController: UIViewController) -> Int?
	func firstPage() -> UIViewController?
	func lastPage() -> UIViewController?
}
	
