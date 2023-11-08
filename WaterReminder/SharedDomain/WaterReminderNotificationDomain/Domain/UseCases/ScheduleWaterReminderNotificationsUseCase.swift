//
//  ScheduleWaterReminderNotificationsUseCase.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 29/06/23.
//

import Foundation

class ScheduleWaterReminderNotificationsUseCase {
	private let waterReminderNotificationManager: WaterReminderNotificationManager

	init(waterReminderNotificationManager: WaterReminderNotificationManager) {
		self.waterReminderNotificationManager = waterReminderNotificationManager
	}

	func scheduleNotifications(startTime: TimePeriod, endTime: TimePeriod, frequency: NotificationFrequencyEnum) {
		waterReminderNotificationManager.clearAllWaterReminderNotifications()
		let intervalPeriod = frequency.timePeriod()
		let intervalTimes = (endTime - startTime) / intervalPeriod
		(0 ..< intervalTimes).forEach { times in
			let reminderTime = startTime + intervalPeriod * times
			var date = DateComponents()
			date.hour = reminderTime.hour
			date.minute = reminderTime.minute
			waterReminderNotificationManager.scheduleReminder(title: String(localized: "notification.title"), message: String(localized: "notification.message"), date: date)
		}
	}
}

extension NotificationFrequencyEnum {
	func timePeriod() -> TimePeriod {
		switch (self) {
		case .high:
			return TimePeriod(hour: 1, minute: 30)
		case .medium:
			return TimePeriod(hour: 2)
		case .low:
			return TimePeriod(hour: 3)
		}
	}
}
