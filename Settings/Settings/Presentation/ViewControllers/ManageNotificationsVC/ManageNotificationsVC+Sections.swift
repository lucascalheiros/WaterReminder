//
//  ManageNotificationsVC+Sections.swift
//  Settings
//
//  Created by Lucas Calheiros on 06/12/23.
//

import Foundation

extension ManageNotificationsVC {
    enum Sections: CaseIterable {
        case weekDays
        case fixedNotifications
    }

    enum SectionItems: Hashable {
        case weekDaysItem(WeekDayUIModel)
        case fixedNotificationItem(FixedNotificationUIModel)
        case addFixedNotification

        static func == (lhs: ManageNotificationsVC.SectionItems, rhs: ManageNotificationsVC.SectionItems) -> Bool {
            switch lhs {

            case .weekDaysItem(let weekDay):
                switch rhs {
                case .weekDaysItem(let weekDayOther):
                    return weekDay == weekDayOther
                default:
                    return false
                }

            case .fixedNotificationItem(let fixedNotification):
                switch rhs {
                case .fixedNotificationItem(let fixedNotificationOther):
                    return fixedNotification == fixedNotificationOther
                default:
                    return false
                }
            case .addFixedNotification:
                switch rhs {
                case .addFixedNotification:
                    return true
                default:
                    return false
                }
            }
        }
    }
}
