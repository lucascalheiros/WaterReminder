//
//  NotificationSettings.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 19/07/23.
//

import Foundation

struct NotificationSettings {
	var isReminderEnabled: Bool = false
	var notificationFrequency: NotificationFrequencyEnum = .medium
	var startTime: TimePeriod
	var endTime: TimePeriod
}
