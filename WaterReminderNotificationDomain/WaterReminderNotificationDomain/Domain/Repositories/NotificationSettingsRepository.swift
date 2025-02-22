//
//  NotificationSettingsRepositoryProtocol.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 27/07/23.
//

import Combine
import Common

protocol NotificationSettingsRepository {
    func setRemindNotificationState(enabled: Bool)
    func setNotificationFrequency(notificationFrequency: NotificationFrequencyEnum)
    func setNotificationsInterval(startTime: TimePeriod, endTime: TimePeriod)
    func setFixedNotifications(_ fixedNotifications: [FixedNotifications])
    func setNotificationWeekDaysState(_ weekDaysState: [NotificationWeekDaysState])

    var isReminderNotificationEnabled: AnyPublisher<Bool, Never> { get }
    var notificationFrequency: AnyPublisher<NotificationFrequencyEnum, Never> { get }
    var notificationStartTime: AnyPublisher<TimePeriod, Never> { get }
    var notificationEndTime: AnyPublisher<TimePeriod, Never> { get }
    var fixedNotifications: AnyPublisher<[FixedNotifications], Never> { get }
    var notificationWeekDaysState: AnyPublisher<[NotificationWeekDaysState], Never> { get }
}
