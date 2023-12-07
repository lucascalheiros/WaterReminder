//
//  NotificationWeekDaysState.swift
//  Settings
//
//  Created by Lucas Calheiros on 02/12/23.
//

public struct NotificationWeekDaysState: Codable, Hashable {
    public let weekDay: WeekDaysEnum
    public var enabled: Bool

    public init(_ weekDay: WeekDaysEnum, _ isEnabled: Bool) {
        self.weekDay = weekDay
        self.enabled = isEnabled
    }
}
