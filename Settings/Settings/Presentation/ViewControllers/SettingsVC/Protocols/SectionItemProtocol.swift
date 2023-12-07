//
//  SectionItemProtocol.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 30/07/23.
//

import Foundation
import UIKit

protocol SectionItemProtocol: CaseIterable {
	func itemTitle() -> String
}
