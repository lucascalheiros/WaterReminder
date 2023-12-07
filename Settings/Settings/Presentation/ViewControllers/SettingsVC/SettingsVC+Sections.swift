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

        func itemTitle() -> String {
            switch self {
            case .dailyWaterVolume:
                return SettingsString.settingsWaterGoal.string()
            }
        }
    }

    enum NotificationSectionItems: SectionItemProtocol {
        case notificationEnabled
        case manageNotifications

        func itemTitle() -> String {
            switch self {
            case .notificationEnabled:
                return SettingsString.settingsNotificationEnabled.string()

            case .manageNotifications:
                return SettingsString.settingsNotificationManage.string()

            }
        }
    }

    enum SettingsSections: CaseIterable {
        case general
        case notification

        func sectionTitle() -> String {
            switch self {
            case .general:
                return SettingsString.settingsSectionGeneral.string()
            case .notification:
                return SettingsString.settingsSectionNotifications.string()
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
