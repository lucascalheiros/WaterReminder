//
//  NotificationSettingsRepositoryImpl.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 27/07/23.
//

import RxSwift

class NotificationSettingsRepositoryImpl: NotificationSettingsRepositoryProtocol {
	lazy var defaults = UserDefaults.standard


	private var isReminderNotificationEnabledObs: NSKeyValueObservation?
	private var notificationFrequencyObs: NSKeyValueObservation?
	private var notificationStartTimeObs: NSKeyValueObservation?
	private var notificationEndTimeObs: NSKeyValueObservation?

	func setNotificationSettings(notificationSettings: NotificationSettings) {
		defaults.set(notificationSettings.isReminderEnabled, forKey: NotificationSettingsUserDefault.reminderNotificationEnabledKey.rawValue)
		defaults.set(notificationSettings.notificationFrequency.rawValue, forKey: NotificationSettingsUserDefault.notificationFrequency.rawValue)
		defaults.set(notificationSettings.startTime.inSeconds(), forKey: NotificationSettingsUserDefault.startTimeSec.rawValue)
		defaults.set(notificationSettings.endTime.inSeconds(), forKey: NotificationSettingsUserDefault.endTimeSec.rawValue)
	}

	func isReminderNotificationEnabled() -> Observable<Bool> {
		return Observable.create { emitter in
			let value = self.defaults.bool(forKey: NotificationSettingsUserDefault.reminderNotificationEnabledKey.rawValue)
			emitter.onNext(value)
			self.isReminderNotificationEnabledObs = self.defaults.observe(\.reminderNotificationEnabled, options: [.new]) { (defaults, change) in
				guard let newValue = change.newValue else { return }
				emitter.onNext(newValue)
			}
			return Disposables.create { self.isReminderNotificationEnabledObs?.invalidate() }
		}
	}

	func notificationFrequency() -> Observable<NotificationFrequencyEnum> {
		return Observable.create { emitter in
			let value = self.defaults.integer(forKey: NotificationSettingsUserDefault.notificationFrequency.rawValue)
			emitter.onNext(NotificationFrequencyEnum(rawValue: value) ?? .medium)
			self.notificationFrequencyObs = self.defaults.observe(\.notificationFrequency, options: [.new]) { (defaults, change) in
				guard let newValue = change.newValue else { return }
				emitter.onNext(NotificationFrequencyEnum(rawValue: newValue) ?? .medium)
			}
			return Disposables.create { self.notificationFrequencyObs?.invalidate() }
		}
	}

	func notificationStartTime() -> Observable<TimePeriod> {
		return Observable.create { emitter in
			let value = self.defaults.integer(forKey: NotificationSettingsUserDefault.startTimeSec.rawValue)
			emitter.onNext(TimePeriod.fromSeconds(seconds: value))
			self.notificationStartTimeObs = self.defaults.observe(\.startTimeSec, options: [.new]) { (defaults, change) in
				guard let newValue = change.newValue else { return }
				emitter.onNext(TimePeriod.fromSeconds(seconds: newValue))
			}
			return Disposables.create { self.notificationStartTimeObs?.invalidate() }
		}
	}

	func notificationEndTime() -> Observable<TimePeriod> {
		return Observable.create { emitter in
			let value = self.defaults.integer(forKey: NotificationSettingsUserDefault.endTimeSec.rawValue)
			emitter.onNext(TimePeriod.fromSeconds(seconds: value))
			self.notificationEndTimeObs = self.defaults.observe(\.endTimeSec, options: [.new]) { (defaults, change) in
				guard let newValue = change.newValue else { return }
				emitter.onNext(TimePeriod.fromSeconds(seconds: newValue))
			}
			return Disposables.create { self.notificationEndTimeObs?.invalidate() }
		}
	}
}

enum NotificationSettingsUserDefault: String {
	case reminderNotificationEnabledKey
	case notificationFrequency
	case startTimeSec
	case endTimeSec
}

extension UserDefaults {
	@objc dynamic var reminderNotificationEnabled: Bool {
		return bool(forKey: NotificationSettingsUserDefault.reminderNotificationEnabledKey.rawValue)
	}

	@objc dynamic var notificationFrequency: Int {
		return integer(forKey: NotificationSettingsUserDefault.reminderNotificationEnabledKey.rawValue)
	}

	@objc dynamic var startTimeSec: Int {
		return integer(forKey: NotificationSettingsUserDefault.startTimeSec.rawValue)
	}

	@objc dynamic var endTimeSec: Int {
		return integer(forKey: NotificationSettingsUserDefault.endTimeSec.rawValue)
	}
}
