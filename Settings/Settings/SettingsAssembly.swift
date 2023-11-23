//
//  SettingsAssembly.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 18/06/23.
//

import Swinject
import SwinjectAutoregistration

public class SettingsAssembly: Assembly {
    public init() {}

	public func assemble(container: Container) {
		container.autoregister(
			SettingsViewController.self,
            initializer: SettingsViewController.newInstance
        )
		container.autoregister(
			SettingsStepper.self,
			initializer: SettingsStepper.init
		).inObjectScope(.container)
		container.autoregister(
			SettingsViewModel.self,
			initializer: SettingsViewModel.init
		)
		container.autoregister(
			PeriodSelectorDelegate.self,
			initializer: PeriodSelectorDelegate.init
		)
		container.autoregister(
			NotificationFrequencySelectorDelegate.self,
			initializer: NotificationFrequencySelectorDelegate.init
		)
		container.autoregister(
			DailyWaterSelectorDelegate.self,
			initializer: DailyWaterSelectorDelegate.init
		)
		container.autoregister(
			NotificationReminderToggleDelegate.self,
			initializer: NotificationReminderToggleDelegate.init
		)
	}
}
