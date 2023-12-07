//
//  IsNotificationEnabledUseCase.swift
//  WaterReminderNotificationDomain
//
//  Created by Lucas Calheiros on 02/12/23.
//

import Foundation
import Combine

public class IsNotificationEnabledUseCase {
    let notificationSettingsRepository: NotificationSettingsRepository

    init(
        notificationSettingsRepository: NotificationSettingsRepository
        ) {
        self.notificationSettingsRepository = notificationSettingsRepository
    }

    public func isNotificationEnabled() -> any Publisher<Bool, Never> {
        notificationSettingsRepository.isReminderNotificationEnabled
    }
}