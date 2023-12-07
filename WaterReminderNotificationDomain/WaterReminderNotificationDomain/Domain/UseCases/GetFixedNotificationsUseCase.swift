//
//  GetFixedNotificationsUseCase.swift
//  WaterReminderNotificationDomain
//
//  Created by Lucas Calheiros on 29/11/23.
//

import Combine
import Common

public class GetFixedNotificationsUseCase {
    let notificationSettingsRepository: NotificationSettingsRepository

    init(
        notificationSettingsRepository: NotificationSettingsRepository
    ) {
        self.notificationSettingsRepository = notificationSettingsRepository
    }

    public func fixedNotifications() -> any Publisher<[FixedNotifications], Never> {
        notificationSettingsRepository.fixedNotifications
    }
}

