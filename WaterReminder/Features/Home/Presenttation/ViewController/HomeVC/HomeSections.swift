//
//  HomeSections.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 12/10/23.
//

import Foundation

enum HomeSections: CaseIterable {
	case mainWaterTracker
	case waterSourceList

	func itemsForSection() -> Int {
		switch self {
		case .mainWaterTracker:
			return 1
		case .waterSourceList:
			return 1
		}
	}
}
