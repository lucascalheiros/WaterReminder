//
//  GetNotificationSettingsUseCase.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 19/07/23.
//

import Combine
import Common

public class GetNotificationSettingsUseCase {
	let notificationSettingsRepository: NotificationSettingsRepository

	init(
		notificationSettingsRepository: NotificationSettingsRepository
	) {
		self.notificationSettingsRepository = notificationSettingsRepository
	}

    public func isReminderNotificationEnabled() -> AnyPublisher<Bool, Never> {
		notificationSettingsRepository.isReminderNotificationEnabled
	}

	public func notificationFrequency() -> AnyPublisher<NotificationFrequencyEnum, Never> {
		notificationSettingsRepository.notificationFrequency
	}

    public func notificationStartTime() -> AnyPublisher<TimePeriod, Never> {
		notificationSettingsRepository.notificationStartTime
	}

    public func notificationEndTime() -> AnyPublisher<TimePeriod, Never> {
		notificationSettingsRepository.notificationEndTime
	}
}

