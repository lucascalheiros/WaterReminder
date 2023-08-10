//
//  NotificationToggleDelegate.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 09/08/23.
//

import RxSwift
import RxRelay

class NotificationReminderToggleDelegate {
	let disposeBag = DisposeBag()

	let getNotificationSettingsUseCase: GetNotificationSettingsUseCase
	let manageNotificationSettingsUseCase: ManageNotificationSettingsUseCase

	lazy var isNotificationReminderEnabled = {
		let isNotificationReminderEnabled = BehaviorRelay(value: false)
		getNotificationSettingsUseCase.isReminderNotificationEnabled()
			.bind(to: isNotificationReminderEnabled)
			.disposed(by: disposeBag)
		return isNotificationReminderEnabled
	}()

	init(
		getNotificationSettingsUseCase: GetNotificationSettingsUseCase,
		 manageNotificationSettingsUseCase: ManageNotificationSettingsUseCase
	) {
		self.getNotificationSettingsUseCase = getNotificationSettingsUseCase
		self.manageNotificationSettingsUseCase = manageNotificationSettingsUseCase
	}

	func setNotificationEnabled(value: Bool) {
		Single.zip(
			getNotificationSettingsUseCase.notificationFrequency().safeAsSingle(),
			getNotificationSettingsUseCase.notificationStartTime().safeAsSingle(),
			getNotificationSettingsUseCase.notificationEndTime().safeAsSingle()
		).subscribe(
			onSuccess: {
				self.manageNotificationSettingsUseCase.setNotificationSetting(
					NotificationSettings(
						isReminderEnabled: value,
						notificationFrequency: $0,
						startTime: $1,
						endTime: $2
					)
				)
			}
		).disposed(by: disposeBag)
	}
}
