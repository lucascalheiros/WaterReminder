//
//  NotificationToggleDelegate.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 09/08/23.
//

import RxRelay
import Combine
import Common
import WaterReminderNotificationDomain

class NotificationReminderToggleDelegate {
    let getNotificationSettingsUseCase: GetNotificationSettingsUseCase
    let manageNotificationSettingsUseCase: ManageNotificationSettingsUseCase

    lazy var isNotificationReminderEnabled = getNotificationSettingsUseCase.isReminderNotificationEnabled()

    init(
        getNotificationSettingsUseCase: GetNotificationSettingsUseCase,
        manageNotificationSettingsUseCase: ManageNotificationSettingsUseCase
    ) {
        self.getNotificationSettingsUseCase = getNotificationSettingsUseCase
        self.manageNotificationSettingsUseCase = manageNotificationSettingsUseCase
    }

    func setNotificationEnabled(value: Bool) {
        Task {
            do {
                for await (frequency, startTime, endTime) in getNotificationSettingsUseCase.notificationFrequency().zip(
                    getNotificationSettingsUseCase.notificationStartTime(),
                    getNotificationSettingsUseCase.notificationEndTime()
                ).values {
                    try await self.manageNotificationSettingsUseCase.setNotificationSetting(NotificationSettings(
                        isReminderEnabled: value,
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
