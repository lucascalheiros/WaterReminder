//
//  SettingsViewModel.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 21/07/23.
//

import RxSwift
import RxCocoa
import WaterManagementDomain

class SettingsViewModel {
	let notificationReminderToggleDelegate: NotificationReminderToggleDelegate
	let dailyWaterSelectorDelegate: DailyWaterSelectorDelegate
	let periodSelectorDelegate: PeriodSelectorDelegate
	let notificationFrequencySelectorDelegate: NotificationFrequencySelectorDelegate

	init(
		notificationReminderToggleDelegate: NotificationReminderToggleDelegate,
		periodSelectorDelegate: PeriodSelectorDelegate,
		getDailyWaterConsumptionUseCase: GetDailyWaterConsumptionUseCaseProtocol,
		notificationFrequencySelectorDelegate: NotificationFrequencySelectorDelegate,
		dailyWaterSelectorDelegate: DailyWaterSelectorDelegate
	) {
		self.notificationReminderToggleDelegate = notificationReminderToggleDelegate
		self.periodSelectorDelegate = periodSelectorDelegate
		self.notificationFrequencySelectorDelegate = notificationFrequencySelectorDelegate
		self.dailyWaterSelectorDelegate = dailyWaterSelectorDelegate
	}
}
