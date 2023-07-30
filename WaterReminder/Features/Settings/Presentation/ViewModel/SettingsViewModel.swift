//
//  SettingsViewModel.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 21/07/23.
//

import RxSwift
import RxCocoa

class SettingsViewModel {
	let getDailyWaterConsumptionUseCase: GetDailyWaterConsumptionUseCase
	let getNotificationSettingsUseCase: GetNotificationSettingsUseCase
	let manageNotificationSettingsUseCase: ManageNotificationSettingsUseCase
	let periodSelectorDelegate: PeriodSelectorDelegate

	let disposeBag = DisposeBag()

	lazy var isNotificationReminderEnabled = {
		let isNotificationReminderEnabled = BehaviorRelay(value: false)
		getNotificationSettingsUseCase.isReminderNotificationEnabled().bind(to: isNotificationReminderEnabled).disposed(by: disposeBag)
		return isNotificationReminderEnabled
	}()

	lazy var periodInterval = Observable.combineLatest(periodSelectorDelegate.initialTime, periodSelectorDelegate.finalTime).map {
		$0.hourAndMinuteAsString() + "-" + $1.hourAndMinuteAsString()
	}

	lazy var notificationFrequency = {
		let notificationFrequency = BehaviorRelay(value: NotificationFrequencyEnum.medium)
		getNotificationSettingsUseCase.notificationFrequency().bind(to: notificationFrequency).disposed(by: disposeBag)
		return notificationFrequency
	}()

	lazy var currentWaterConsumption = getDailyWaterConsumptionUseCase.lastDailyWaterConsumption().map {
		String($0?.expectedVolume ?? 0) + " ml"
	}

	init(
		getNotificationSettingsUseCase: GetNotificationSettingsUseCase,
		manageNotificationSettingsUseCase: ManageNotificationSettingsUseCase,
		periodSelectorDelegate: PeriodSelectorDelegate,
		getDailyWaterConsumptionUseCase: GetDailyWaterConsumptionUseCase
	) {
		self.getNotificationSettingsUseCase = getNotificationSettingsUseCase
		self.manageNotificationSettingsUseCase = manageNotificationSettingsUseCase
		self.periodSelectorDelegate = periodSelectorDelegate
		self.getDailyWaterConsumptionUseCase = getDailyWaterConsumptionUseCase
	}

	func setNotificationEnabled(value: Bool) {
		Single.zip(
			getNotificationSettingsUseCase.notificationFrequency().safeAsSingle(),
			getNotificationSettingsUseCase.notificationStartTime().safeAsSingle(),
			getNotificationSettingsUseCase.notificationEndTime().safeAsSingle()
		).subscribe(
			onSuccess: {
				self.manageNotificationSettingsUseCase.setNotificationSetting(notificationSettings: NotificationSettings(
					isReminderEnabled: value,
					notificationFrequency: $0,
					startTime: $1,
					endTime: $2
				))
			}
		).disposed(by: disposeBag)
	}

	func setNotificationFrequency(frequency: NotificationFrequencyEnum) {
		Single.zip(
			getNotificationSettingsUseCase.isReminderNotificationEnabled().safeAsSingle(),
			getNotificationSettingsUseCase.notificationStartTime().safeAsSingle(),
			getNotificationSettingsUseCase.notificationEndTime().safeAsSingle()
		).subscribe(
			onSuccess: {
				self.manageNotificationSettingsUseCase.setNotificationSetting(notificationSettings: NotificationSettings(
					isReminderEnabled: $0,
					notificationFrequency: frequency,
					startTime: $1,
					endTime: $2
				))
			}
		).disposed(by: disposeBag)
	}

}
