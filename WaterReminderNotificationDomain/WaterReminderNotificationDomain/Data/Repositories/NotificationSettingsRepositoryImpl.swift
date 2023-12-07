//
//  NotificationSettingsRepositoryImpl.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 27/07/23.
//

import Common
import Combine
import Foundation

class NotificationSettingsRepositoryImpl: NotificationSettingsRepository {
    private lazy var defaults = UserDefaults.standard

    private lazy var _isReminderNotificationEnabled = CurrentValueSubject<Bool, Never>(defaults.reminderNotificationEnabled)
    lazy var isReminderNotificationEnabled = _isReminderNotificationEnabled.eraseToAnyPublisher()

    private lazy var _notificationFrequency = CurrentValueSubject<NotificationFrequencyEnum, Never>(NotificationFrequencyEnum(rawValue: defaults.notificationFrequency) ?? .medium)
    lazy var notificationFrequency = _notificationFrequency.eraseToAnyPublisher()

    private lazy var _notificationStartTime = CurrentValueSubject<TimePeriod, Never>(TimePeriod.fromSeconds(seconds: defaults.startTimeSec))
    lazy var notificationStartTime = _notificationStartTime.eraseToAnyPublisher()

    private lazy var _notificationEndTime = CurrentValueSubject<TimePeriod, Never>(TimePeriod.fromSeconds(seconds: defaults.endTimeSec))
    lazy var notificationEndTime = _notificationEndTime.eraseToAnyPublisher()

    private lazy var _fixedNotifications = CurrentValueSubject<[FixedNotifications], Never>(defaults.fixedNotificationsAny.toFixedNotifications())
    lazy var fixedNotifications = _fixedNotifications.eraseToAnyPublisher()

    private lazy var _notificationWeekDaysState = CurrentValueSubject<[NotificationWeekDaysState], Never>(defaults.weekDaysStateAny.toWeekDaysState())
    lazy var notificationWeekDaysState = _notificationWeekDaysState.eraseToAnyPublisher()

    func setRemindNotificationState(enabled: Bool) {
        defaults.reminderNotificationEnabled = enabled
        _isReminderNotificationEnabled.value = enabled
    }

    func setNotificationFrequency(notificationFrequency: NotificationFrequencyEnum) {
        defaults.notificationFrequency = notificationFrequency.rawValue
        _notificationFrequency.value = notificationFrequency
    }

    func setNotificationsInterval(startTime: TimePeriod, endTime: TimePeriod) {
        defaults.startTimeSec = startTime.inSeconds()
        defaults.endTimeSec = endTime.inSeconds()
        _notificationStartTime.value = startTime
        _notificationEndTime.value = endTime
    }

    func setFixedNotifications(_ fixedNotifications: [FixedNotifications]) {
        do {
            let encodedData = try JSONEncoder().encode(fixedNotifications)
            defaults.set(encodedData, forKey: NotificationSettingsUserDefault.fixedNotifications.rawValue)
            _fixedNotifications.value = fixedNotifications
        } catch {
        }
    }

    func setNotificationWeekDaysState(_ weekDaysState: [NotificationWeekDaysState]) {
        do {
            let encodedData = try JSONEncoder().encode(weekDaysState)
            defaults.set(encodedData, forKey: NotificationSettingsUserDefault.weekDaysState.rawValue)
            _notificationWeekDaysState.value = weekDaysState
        } catch {
        }
    }
}

enum NotificationSettingsUserDefault: String {
    case reminderNotificationEnabledKey
    case notificationFrequency
    case startTimeSec
    case endTimeSec
    case fixedNotifications
    case weekDaysState
}

extension UserDefaults {
    @objc dynamic var reminderNotificationEnabled: Bool {
        get {
            bool(forKey: NotificationSettingsUserDefault.reminderNotificationEnabledKey.rawValue)        }
        set {
            set(newValue, forKey: NotificationSettingsUserDefault.reminderNotificationEnabledKey.rawValue)
        }
    }

    @objc dynamic var notificationFrequency: Int {
        get {
            integer(forKey: NotificationSettingsUserDefault.notificationFrequency.rawValue)
        }
        set {
            set(newValue, forKey: NotificationSettingsUserDefault.notificationFrequency.rawValue)
        }
    }

    @objc dynamic var startTimeSec: Int {
        get {
            integer(forKey: NotificationSettingsUserDefault.startTimeSec.rawValue)
        }
        set {
            set(newValue, forKey: NotificationSettingsUserDefault.startTimeSec.rawValue)
        }
    }

    @objc dynamic var endTimeSec: Int {
        get {
            integer(forKey: NotificationSettingsUserDefault.endTimeSec.rawValue)
        }
        set {
            set(newValue, forKey: NotificationSettingsUserDefault.endTimeSec.rawValue)
        }
    }

    @objc dynamic var fixedNotificationsAny: Any? {
        get {
            object(forKey: NotificationSettingsUserDefault.fixedNotifications.rawValue)
        }
        set {
            set(newValue, forKey: NotificationSettingsUserDefault.fixedNotifications.rawValue)
        }
    }

    @objc dynamic var weekDaysStateAny: Any? {
        get {
            object(forKey: NotificationSettingsUserDefault.weekDaysState.rawValue)
        }
        set {
            set(newValue, forKey: NotificationSettingsUserDefault.weekDaysState.rawValue)
        }
    }
}

extension Optional {
    func toFixedNotifications() -> [FixedNotifications] {
        if let savedData = self as? Data {
            do{
                return try JSONDecoder().decode([FixedNotifications].self, from: savedData)
            } catch {
            }
        }
        return []
    }

    func toWeekDaysState() -> [NotificationWeekDaysState] {
        if let savedData = self as? Data {
            do{
                return try JSONDecoder().decode([NotificationWeekDaysState].self, from: savedData)
            } catch {
            }
        }
        return []
    }
}
