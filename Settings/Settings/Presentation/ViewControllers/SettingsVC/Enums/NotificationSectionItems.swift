//
//  NotificationSectionItems.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 30/07/23.
//

import UIKit

enum NotificationSectionItems: SectionItem {
	case notificationEnabled
    case manageNotifications

	func itemTitle() -> String {
		switch self {
		case .notificationEnabled:
			return String(localized: "settings.section.notifications.notificationEnabled")
        case .manageNotifications:
            return String(localized: "settings.section.notifications.manage")
        }
	}
}
