//
//  GetNotificationSettingsUseCase.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 19/07/23.
//

import RxSwift
import Common

public class GetNotificationSettingsUseCase {
	let notificationSettingsRepository: NotificationSettingsRepositoryProtocol

	init(
		notificationSettingsRepository: NotificationSettingsRepositoryProtocol
	) {
		self.notificationSettingsRepository = notificationSettingsRepository
	}

    public func isReminderNotificationEnabled() -> Observable<Bool> {
		notificationSettingsRepository.isReminderNotificationEnabled()
	}

	public func notificationFrequency() -> Observable<NotificationFrequencyEnum> {
		notificationSettingsRepository.notificationFrequency()
	}

    public func notificationStartTime() -> Observable<TimePeriod> {
		notificationSettingsRepository.notificationStartTime()
	}

    public func notificationEndTime() -> Observable<TimePeriod> {
		notificationSettingsRepository.notificationEndTime()
	}
}

