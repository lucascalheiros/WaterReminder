//
//  ManageNotificationSettingsUseCase.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 19/07/23.
//

import Foundation

class ManageNotificationSettingsUseCase {
	let scheduleWaterReminderNotificationsUseCase: ScheduleWaterReminderNotificationsUseCase
	let waterReminderNotificationManager: WaterReminderNotificationManager
	let notificationSettingsRepository: NotificationSettingsRepositoryProtocol

	init(
		scheduleWaterReminderNotificationsUseCase: ScheduleWaterReminderNotificationsUseCase,
		waterReminderNotificationManager: WaterReminderNotificationManager,
		notificationSettingsRepository: NotificationSettingsRepositoryProtocol
	) {
		self.scheduleWaterReminderNotificationsUseCase = scheduleWaterReminderNotificationsUseCase
		self.waterReminderNotificationManager = waterReminderNotificationManager
		self.notificationSettingsRepository = notificationSettingsRepository
	}

	func setNotificationSetting(_ notificationSettings: NotificationSettings) {
		notificationSettingsRepository.setNotificationSettings(notificationSettings: notificationSettings)
		if notificationSettings.isReminderEnabled {
			scheduleWaterReminderNotificationsUseCase.scheduleNotifications(
				startTime: notificationSettings.startTime,
				endTime: notificationSettings.endTime,
				frequency: notificationSettings.notificationFrequency
			)
		} else {
			waterReminderNotificationManager.clearAllWaterReminderNotifications()
		}
	}
}
