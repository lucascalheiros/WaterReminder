//
//  GetNotificationSettingsUseCase.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 19/07/23.
//

import RxSwift

class GetNotificationSettingsUseCase {
	let notificationSettingsRepository: NotificationSettingsRepositoryProtocol

	init(
		notificationSettingsRepository: NotificationSettingsRepositoryProtocol
	) {
		self.notificationSettingsRepository = notificationSettingsRepository
	}

	func isReminderNotificationEnabled() -> Observable<Bool> {
		notificationSettingsRepository.isReminderNotificationEnabled()
	}

	func notificationFrequency() -> Observable<NotificationFrequencyEnum> {
		notificationSettingsRepository.notificationFrequency()
	}

	func notificationStartTime() -> Observable<TimePeriod> {
		notificationSettingsRepository.notificationStartTime()
	}

	func notificationEndTime() -> Observable<TimePeriod> {
		notificationSettingsRepository.notificationEndTime()
	}
}

