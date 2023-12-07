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
    let settingsStepper: SettingsStepper

	init(
		notificationReminderToggleDelegate: NotificationReminderToggleDelegate,
		periodSelectorDelegate: PeriodSelectorDelegate,
		notificationFrequencySelectorDelegate: NotificationFrequencySelectorDelegate,
		dailyWaterSelectorDelegate: DailyWaterSelectorDelegate,
        settingsStepper: SettingsStepper
	) {
		self.notificationReminderToggleDelegate = notificationReminderToggleDelegate
		self.periodSelectorDelegate = periodSelectorDelegate
		self.notificationFrequencySelectorDelegate = notificationFrequencySelectorDelegate
		self.dailyWaterSelectorDelegate = dailyWaterSelectorDelegate
        self.settingsStepper = settingsStepper
	}

    func presentNotificationManager() {
        settingsStepper.steps.accept(SettingsFlowSteps.manageNotifications)
    }
}
