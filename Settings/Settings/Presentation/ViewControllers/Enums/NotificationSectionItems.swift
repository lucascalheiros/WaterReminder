//
//  NotificationSectionItems.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 30/07/23.
//

import Foundation

enum NotificationSectionItems: SectionItem {
	case notificationEnabled
	case notificationPeriod
	case notificationFrequency

	func itemTitle() -> String {
		switch self {
		case .notificationEnabled:
			return String(localized: "settings.section.notifications.notificationEnabled")
		case .notificationPeriod:
			return String(localized: "settings.section.notifications.period")
		case .notificationFrequency:
			return String(localized: "settings.section.notifications.frequency")
		}
	}
}
