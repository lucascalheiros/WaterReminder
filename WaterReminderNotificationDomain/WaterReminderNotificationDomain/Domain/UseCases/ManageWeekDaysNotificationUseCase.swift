//
//  ManageWeekDaysNotificationUseCase.swift
//  WaterReminderNotificationDomain
//
//  Created by Lucas Calheiros on 04/12/23.
//

import Foundation

public class ManageWeekDaysNotificationUseCase {
    let notificationSettingsRepository: NotificationSettingsRepository
    let scheduleWaterReminderNotificationsUseCase: ScheduleWaterReminderNotificationsUseCase

    init(
        notificationSettingsRepository: NotificationSettingsRepository,
        scheduleWaterReminderNotificationsUseCase: ScheduleWaterReminderNotificationsUseCase
    ) {
        self.notificationSettingsRepository = notificationSettingsRepository
        self.scheduleWaterReminderNotificationsUseCase = scheduleWaterReminderNotificationsUseCase
    }

    public func saveWeekDayNotificationState(_ state: NotificationWeekDaysState) async throws {
        var list = try await notificationSettingsRepository.notificationWeekDaysState.awaitFirst()
        list.removeAll(where: { $0.weekDay == state.weekDay })
        list.append(state)
        notificationSettingsRepository.setNotificationWeekDaysState(list)
        for await isEnabled: Bool in notificationSettingsRepository.isReminderNotificationEnabled.eraseToAnyPublisher().values {
            if isEnabled {
                try await self.scheduleWaterReminderNotificationsUseCase.scheduleNotifications()
            }
        }
    }
}
