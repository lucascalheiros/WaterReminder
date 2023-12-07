//
//  WaterReminderNotificationDomainAssembly.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 01/07/23.
//

import Swinject
import SwinjectAutoregistration

public class WaterReminderNotificationDomainAssembly: Assembly {

    public init() {}

	public func assemble(container: Container) {
		container.autoregister(
			WaterReminderNotificationManager.self,
			initializer: WaterReminderNotificationManagerImpl.init
        ).inObjectScope(.weak)
		container.autoregister(
			ScheduleWaterReminderNotificationsUseCase.self,
			initializer: ScheduleWaterReminderNotificationsUseCase.init
        ).inObjectScope(.weak)
		container.autoregister(
			GetNotificationSettingsUseCase.self,
			initializer: GetNotificationSettingsUseCase.init
        ).inObjectScope(.weak)
		container.autoregister(
			ManageNotificationSettingsUseCase.self,
			initializer: ManageNotificationSettingsUseCase.init
        ).inObjectScope(.weak)
        container.autoregister(
            NotificationSettingsRepository.self,
            initializer: NotificationSettingsRepositoryImpl.init
        ).inObjectScope(.weak)
        container.autoregister(
            ManageFixedNotificationsUseCase.self,
            initializer: ManageFixedNotificationsUseCase.init
        ).inObjectScope(.weak)
		container.autoregister(
            GetFixedNotificationsUseCase.self,
			initializer: GetFixedNotificationsUseCase.init
        ).inObjectScope(.weak)
        container.autoregister(
            GetWeekDaysNotificationUseCase.self,
            initializer: GetWeekDaysNotificationUseCase.init
        ).inObjectScope(.weak)
        container.autoregister(
            ManageWeekDaysNotificationUseCase.self,
            initializer: ManageWeekDaysNotificationUseCase.init
        ).inObjectScope(.weak)
	}
}
