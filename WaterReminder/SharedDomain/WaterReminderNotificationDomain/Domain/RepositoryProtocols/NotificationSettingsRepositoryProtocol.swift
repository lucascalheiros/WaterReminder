//
//  NotificationSettingsRepositoryProtocol.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 27/07/23.
//

import RxSwift

protocol NotificationSettingsRepositoryProtocol {
	func setNotificationSettings(notificationSettings: NotificationSettings)
	func isReminderNotificationEnabled() -> Observable<Bool>
	func notificationFrequency() -> Observable<NotificationFrequencyEnum>
	func notificationStartTime() -> Observable<TimePeriod>
	func notificationEndTime() -> Observable<TimePeriod>
}
