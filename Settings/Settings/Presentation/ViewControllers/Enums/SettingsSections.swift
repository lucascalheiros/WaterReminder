//
//  SettingsSections.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 30/07/23.
//

import Foundation

enum SettingsSections: CaseIterable {
	case general
	case notification

	func sectionTitle() -> String {
		switch self {
		case .general:
			return String(localized: "settings.section.general")
		case .notification:
            return String(localized: "settings.section.notifications")
		}
	}

	func sectionItems() -> [any SectionItem] {
		switch self {
		case .general:
			return GeneralSectionItems.allCases
		case .notification:
			return NotificationSectionItems.allCases
		}
	}
}
