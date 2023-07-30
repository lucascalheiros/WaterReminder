//
//  SectionItemProtocol.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 30/07/23.
//

import Foundation

protocol SectionItemProtocol {
	func itemTitle() -> String
}

typealias SectionItem = SectionItemProtocol&CaseIterable
