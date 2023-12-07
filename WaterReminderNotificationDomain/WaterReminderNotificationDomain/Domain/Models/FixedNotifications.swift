//
//  FixedNotifications.swift
//  WaterReminderNotificationDomain
//
//  Created by Lucas Calheiros on 25/11/23.
//

import Common

public struct FixedNotifications: Codable, Hashable {
    public let timePeriod: TimePeriod
    public var enabled: Bool

    public init(_ timePeriod: TimePeriod, _ enabled: Bool) {
        self.timePeriod = timePeriod
        self.enabled = enabled
    }
}
