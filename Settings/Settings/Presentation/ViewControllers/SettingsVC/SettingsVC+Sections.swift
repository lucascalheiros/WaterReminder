//
//  SettingsVC+Sections.swift
//  Settings
//
//  Created by Lucas Calheiros on 06/12/23.
//

import Foundation

extension SettingsVC {

    enum SettingsItem: Hashable {
        case general(GeneralSectionItems)
        case notification(NotificationSectionItems)
        case profile(ProfileSectionItems)
    }

    enum GeneralSectionItems: SectionItemProtocol {
        case dailyWaterVolume
        case volumeFormat
        case theme

        func itemTitle() -> String {
            switch self {

            case .dailyWaterVolume:
                String(localized: "Daily Water Intake")

            case .volumeFormat:
                String(localized: "Units")

            case .theme:
                String(localized: "Theme")
            }
        }
    }

    enum NotificationSectionItems: SectionItemProtocol {
        case notificationEnabled
        case manageNotifications

        func itemTitle() -> String {
            switch self {

            case .notificationEnabled:
                String(localized: "settings.section.notifications.notificationEnabled")

            case .manageNotifications:
                String(localized: "settings.section.notifications.manage")
            }
        }
    }


    enum ProfileSectionItems: SectionItemProtocol {
        case weight
        case activityLevel
        case temperatureLevel
        case calculatedIntake

        func itemTitle() -> String {
            switch self {

            case .weight:
                String(localized: "Weight")
            case .activityLevel:
                String(localized: "Activity Level")
            case .temperatureLevel:
                String(localized: "Temperature Level")
            case .calculatedIntake:
                String(localized: "Calculated Intake")
            }
        }
    }

    enum SettingsSections: CaseIterable {
        case general
        case notification
        case profile

        func sectionTitle() -> String {
            switch self {

            case .general:
                String(localized: "settings.section.general")

            case .notification:
                String(localized: "settings.section.notifications")

            case .profile:
                String(localized: "Profile")

            }
        }

        func sectionItems() -> [any SectionItemProtocol] {
            switch self {

            case .general:
                GeneralSectionItems.allCases

            case .notification:
                NotificationSectionItems.allCases

            case .profile:
                ProfileSectionItems.allCases
            }
        }
    }

}
