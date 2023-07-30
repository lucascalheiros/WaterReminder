//
//  GeneralSectionItems.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 30/07/23.
//

import Foundation

enum GeneralSectionItems: SectionItem {
	case dailyWaterVolume

	func itemTitle() -> String {
		switch self {
		case .dailyWaterVolume:
			return "Daily water goal"
		}
	}
}
