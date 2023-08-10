//
//  NotificationFrequencySelectorDelegate.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 02/08/23.
//

import RxSwift
import RxCocoa

class NotificationFrequencySelectorDelegate {
	let disposeBag = DisposeBag()

	let getNotificationSettingsUseCase: GetNotificationSettingsUseCase
	let manageNotificationSettingsUseCase: ManageNotificationSettingsUseCase

	lazy var notificationFrequency = {
		let notificationFrequency = BehaviorRelay(value: NotificationFrequencyEnum.medium)
		getNotificationSettingsUseCase.notificationFrequency().bind(to: notificationFrequency).disposed(by: disposeBag)
		return notificationFrequency
	}()

	init(getNotificationSettingsUseCase: GetNotificationSettingsUseCase, manageNotificationSettingsUseCase: ManageNotificationSettingsUseCase) {
		self.getNotificationSettingsUseCase = getNotificationSettingsUseCase
		self.manageNotificationSettingsUseCase = manageNotificationSettingsUseCase
	}

	func setNotificationFrequency(frequency: NotificationFrequencyEnum) {
		Single.zip(
			getNotificationSettingsUseCase.isReminderNotificationEnabled().safeAsSingle(),
			getNotificationSettingsUseCase.notificationStartTime().safeAsSingle(),
			getNotificationSettingsUseCase.notificationEndTime().safeAsSingle()
		).subscribe(
			onSuccess: {
				self.manageNotificationSettingsUseCase.setNotificationSetting(NotificationSettings(
					isReminderEnabled: $0,
					notificationFrequency: frequency,
					startTime: $1,
					endTime: $2
				))
			}
		).disposed(by: disposeBag)
	}
}
