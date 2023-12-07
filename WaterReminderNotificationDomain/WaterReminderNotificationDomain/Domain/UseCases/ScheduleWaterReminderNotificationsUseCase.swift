//
//  ScheduleWaterReminderNotificationsUseCase.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 29/06/23.
//

import Foundation
import Common
import Combine

class ScheduleWaterReminderNotificationsUseCase {
	private let waterReminderNotificationManager: WaterReminderNotificationManager
	private let notificationSettingsRepository: NotificationSettingsRepository

	init(
		waterReminderNotificationManager: WaterReminderNotificationManager,
		notificationSettingsRepository: NotificationSettingsRepository
	) {
		self.waterReminderNotificationManager = waterReminderNotificationManager
		self.notificationSettingsRepository = notificationSettingsRepository
	}

	private func scheduleNotifications(startTime: TimePeriod, endTime: TimePeriod, frequency: NotificationFrequencyEnum) {
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

	private func scheduleNotifications(timePeriodList: [TimePeriod], weekDays: [WeekDaysEnum]) {
		waterReminderNotificationManager.clearAllWaterReminderNotifications()
		for weekDay in weekDays {
			for reminderTime in timePeriodList {
				var date = DateComponents()
				date.hour = reminderTime.hour
				date.minute = reminderTime.minute
				date.weekday = weekDay.rawValue
				waterReminderNotificationManager.scheduleReminder(title: String(localized: "notification.title"), message: String(localized: "notification.message"), date: date)
			}
		}
	}

	func scheduleNotifications() async throws {
		let isEnabled = try await notificationSettingsRepository.isReminderNotificationEnabled.awaitFirst()
		if isEnabled {
			let timePeriodList = try await notificationSettingsRepository.fixedNotifications.awaitFirst().filter { $0.enabled }.map { $0.timePeriod }
			let excludedWeekDays = try await notificationSettingsRepository.notificationWeekDaysState.awaitFirst().filter { !$0.enabled }.map { $0.weekDay }
			let weekDays = WeekDaysEnum.allCases.filter { !excludedWeekDays.contains($0) }
			scheduleNotifications(
				timePeriodList: timePeriodList,
				weekDays: weekDays
				)
		} else {
			waterReminderNotificationManager.clearAllWaterReminderNotifications()
		}
	}
}
