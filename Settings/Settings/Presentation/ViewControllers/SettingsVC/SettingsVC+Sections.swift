//
//  SettingsVC+Sections.swift
//  Settings
//
//  Created by Lucas Calheiros on 06/12/23.
//

import Foundation

extension SettingsVC {
    enum GeneralSectionItems: SectionItemProtocol {
        case dailyWaterVolume
        case volumeFormat

        func itemTitle() -> String {
            switch self {

            case .dailyWaterVolume:
                return String(localized: "Daily Goal")

            case .volumeFormat:
                return String(localized: "Volume Format")
            }
        }
    }

    enum NotificationSectionItems: SectionItemProtocol {
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

        func sectionItems() -> [any SectionItemProtocol] {
            switch self {

            case .general:
                return GeneralSectionItems.allCases

            case .notification:
                return NotificationSectionItems.allCases
            }
        }
    }

}
