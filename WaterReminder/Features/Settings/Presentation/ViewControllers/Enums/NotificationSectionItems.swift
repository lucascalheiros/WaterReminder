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
			return "Notifications enabled"
		case .notificationPeriod:
			return "Period"
		case .notificationFrequency:
			return "Frequency"
		}
	}
}
