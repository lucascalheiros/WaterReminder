//
//  GeneralSectionItems.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 30/07/23.
//

import UIKit

enum GeneralSectionItems: SectionItem {
	case dailyWaterVolume

	func itemTitle() -> String {
		switch self {
		case .dailyWaterVolume:
			return String(localized: "settings.section.general.goal")
		}
	}
}
