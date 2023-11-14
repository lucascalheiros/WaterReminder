//
//  PeriodSelectorDelegate.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 29/07/23.
//

import RxSwift
import RxCocoa
import Common

class PeriodSelectorDelegate {
	let disposeBag = DisposeBag()

	let getNotificationSettingsUseCase: GetNotificationSettingsUseCase
	let manageNotificationSettingsUseCase: ManageNotificationSettingsUseCase

	lazy var periodInterval = Observable.combineLatest(initialTime, finalTime).map {
		$0.hourAndMinuteAsString() + "-" + $1.hourAndMinuteAsString()
	}

	lazy var initialTime = {
		let initialTime = BehaviorRelay(value: TimePeriod.fromSeconds(seconds: 0))
		getNotificationSettingsUseCase.notificationStartTime().bind(to: initialTime).disposed(by: disposeBag)
		return initialTime
	}()
	lazy var finalTime = {
		let finalTime = BehaviorRelay(value: TimePeriod.fromSeconds(seconds: 0))
		getNotificationSettingsUseCase.notificationEndTime().bind(to: finalTime).disposed(by: disposeBag)
		return finalTime
	}()

	init(getNotificationSettingsUseCase: GetNotificationSettingsUseCase, manageNotificationSettingsUseCase: ManageNotificationSettingsUseCase) {
		self.getNotificationSettingsUseCase = getNotificationSettingsUseCase
		self.manageNotificationSettingsUseCase = manageNotificationSettingsUseCase
	}

	func setNotificationPeriod(startTime: TimePeriod, endTime: TimePeriod) {
		Single.zip(
			getNotificationSettingsUseCase.isReminderNotificationEnabled().safeAsSingle(),
			getNotificationSettingsUseCase.notificationFrequency().safeAsSingle()
		).subscribe(
			onSuccess: {
				self.manageNotificationSettingsUseCase.setNotificationSetting(
					NotificationSettings(
						isReminderEnabled: $0,
						notificationFrequency: $1,
						startTime: startTime,
						endTime: endTime
					)
				)
			}
		).disposed(by: disposeBag)
	}
}
