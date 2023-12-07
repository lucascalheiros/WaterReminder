//
//  ManageNotificationSettingsUseCase.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 19/07/23.
//

import Foundation

public class ManageNotificationSettingsUseCase {
	let scheduleWaterReminderNotificationsUseCase: ScheduleWaterReminderNotificationsUseCase
	let waterReminderNotificationManager: WaterReminderNotificationManager
	let notificationSettingsRepository: NotificationSettingsRepository

	init(
		scheduleWaterReminderNotificationsUseCase: ScheduleWaterReminderNotificationsUseCase,
		waterReminderNotificationManager: WaterReminderNotificationManager,
		notificationSettingsRepository: NotificationSettingsRepository
	) {
		self.scheduleWaterReminderNotificationsUseCase = scheduleWaterReminderNotificationsUseCase
		self.waterReminderNotificationManager = waterReminderNotificationManager
		self.notificationSettingsRepository = notificationSettingsRepository
	}

	public func setNotificationSetting(_ notificationSettings: NotificationSettings) async throws {
        notificationSettingsRepository.setRemindNotificationState(enabled: notificationSettings.isReminderEnabled)
        notificationSettingsRepository.setNotificationFrequency(notificationFrequency: notificationSettings.notificationFrequency)
        notificationSettingsRepository.setNotificationsInterval(startTime: notificationSettings.startTime, endTime: notificationSettings.endTime)
		if notificationSettings.isReminderEnabled {
			try await scheduleWaterReminderNotificationsUseCase.scheduleNotifications()
		} else {
			waterReminderNotificationManager.clearAllWaterReminderNotifications()
		}
	}
}
