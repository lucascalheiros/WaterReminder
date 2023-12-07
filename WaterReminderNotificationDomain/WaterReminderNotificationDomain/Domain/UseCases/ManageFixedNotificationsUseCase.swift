//
//  ManageFixedNotificationsUseCase.swift
//  WaterReminderNotificationDomain
//
//  Created by Lucas Calheiros on 29/11/23.
//

import RxRelay
import RxSwift
import Common

public class ManageFixedNotificationsUseCase {
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
    
    public func saveFixedNotification(_ fixedNotifications: FixedNotifications) async throws {
        var list = try await notificationSettingsRepository.fixedNotifications.awaitFirst()
        list.removeAll(where: { $0.timePeriod == fixedNotifications.timePeriod })
        list.append(fixedNotifications)
        notificationSettingsRepository.setFixedNotifications(list)
        try await self.scheduleWaterReminderNotificationsUseCase.scheduleNotifications()
    }
    
    public func addFixedNotification(timePeriod: TimePeriod) async throws {
        var notifications = try await notificationSettingsRepository.fixedNotifications.awaitFirst()
        if !notifications.contains(where: { $0.timePeriod.inSeconds() == timePeriod.inSeconds() }) {
            notifications.append(FixedNotifications(timePeriod, true))
            notifications.sort(by: { $0.timePeriod < $1.timePeriod })
        }
        notificationSettingsRepository.setFixedNotifications(notifications)
        try await self.scheduleWaterReminderNotificationsUseCase.scheduleNotifications()
    }
    
    public func removeFixedNotification(timePeriod: TimePeriod) async throws {
        var notifications = try await notificationSettingsRepository.fixedNotifications.awaitFirst()
        notifications.removeAll(where: { $0.timePeriod.inSeconds() == timePeriod.inSeconds() })
        notificationSettingsRepository.setFixedNotifications(notifications)
        try await self.scheduleWaterReminderNotificationsUseCase.scheduleNotifications()
    }
}

