//
//  NotificationSettings.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 19/07/23.
//

import Foundation
import Common

public struct NotificationSettings {
	public var isReminderEnabled: Bool = false
    public var notificationFrequency: NotificationFrequencyEnum = .medium
    public var startTime: TimePeriod
    public var endTime: TimePeriod

    public init(isReminderEnabled: Bool, notificationFrequency: NotificationFrequencyEnum, startTime: TimePeriod, endTime: TimePeriod) {
        self.isReminderEnabled = isReminderEnabled
        self.notificationFrequency = notificationFrequency
        self.startTime = startTime
        self.endTime = endTime
    }
}
