//
//  SettingsString.swift
//  Settings
//
//  Created by Lucas Calheiros on 06/12/23.
//

enum SettingsString: String, CaseIterable {
    case settingsTitle
    case settingsWaterGoal
    case settingsNotificationEnabled
    case settingsNotificationManage
    case settingsSectionGeneral
    case settingsSectionNotifications
    case addFixedNotificationsAdd
    case addFixedNotificationsTitle
    case manageNotificationsTitle
    case manageNotificationsByDay
    case manageNotificationsWeekDay
    case cancel
    case confirm

    func string() -> String {
        switch self {

        case .settingsTitle:
            String(localized: "settings.screenTitle", table: "Settings")
        case .settingsWaterGoal:
            String(localized:
                    "settings.section.general.goal", table: "Settings")
        case .settingsNotificationEnabled:
            String(localized: "settings.section.notifications.notificationEnabled", table: "Settings")
        case .settingsNotificationManage:
            String(localized: "settings.section.notifications.manage", table: "Settings")
        case .settingsSectionGeneral:
            String(localized: "settings.section.general", table: "Settings")
        case .settingsSectionNotifications:
            String(localized: "settings.section.notifications", table: "Settings")
        case .addFixedNotificationsAdd:
            String(localized:
                    "manageNotifications.addFixedNotification", table: "Settings")
        case .addFixedNotificationsTitle:
            String(localized: "addFixedNotification.title", table: "Settings")
        case .manageNotificationsTitle:
            String(localized: "manageNotifications.title", table: "Settings")
        case .manageNotificationsByDay:
            String(localized: "manageNotifications.section.notificationsByDay", table: "Settings")
        case .manageNotificationsWeekDay:
            String(localized: "manageNotifications.section.weekDays", table: "Settings")
        case .cancel:
            String(localized: "generic.cancel", table: "Settings")
        case .confirm:
            String(localized: "generic.confirm", table: "Settings")
        }
    }
}
