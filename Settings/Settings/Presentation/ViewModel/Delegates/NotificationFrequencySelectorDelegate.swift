//
//  NotificationFrequencySelectorDelegate.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 02/08/23.
//

import Combine
import WaterReminderNotificationDomain

class NotificationFrequencySelectorDelegate {

	let getNotificationSettingsUseCase: GetNotificationSettingsUseCase
	let manageNotificationSettingsUseCase: ManageNotificationSettingsUseCase

    lazy var notificationFrequency = getNotificationSettingsUseCase.notificationFrequency()

	init(getNotificationSettingsUseCase: GetNotificationSettingsUseCase, manageNotificationSettingsUseCase: ManageNotificationSettingsUseCase) {
		self.getNotificationSettingsUseCase = getNotificationSettingsUseCase
		self.manageNotificationSettingsUseCase = manageNotificationSettingsUseCase
	}

	func setNotificationFrequency(frequency: NotificationFrequencyEnum) {
        Task {
            do {
                for await (isEnabled, startTime, endTime) in getNotificationSettingsUseCase.isReminderNotificationEnabled().zip(
                    getNotificationSettingsUseCase.notificationStartTime(),
                    getNotificationSettingsUseCase.notificationEndTime()
                    ).values {
                    try await self.manageNotificationSettingsUseCase.setNotificationSetting(NotificationSettings(
                        isReminderEnabled: isEnabled,
                        notificationFrequency: frequency,
                        startTime: startTime,
                        endTime: endTime
                        ))
                        return
                }
            } catch {

            }
        }
	}
}
