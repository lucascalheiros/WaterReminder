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
		)
		container.autoregister(
			ScheduleWaterReminderNotificationsUseCase.self,
			initializer: ScheduleWaterReminderNotificationsUseCase.init
		)
		container.autoregister(
			GetNotificationSettingsUseCase.self,
			initializer: GetNotificationSettingsUseCase.init
		)
		container.autoregister(
			ManageNotificationSettingsUseCase.self,
			initializer: ManageNotificationSettingsUseCase.init
		)
		container.autoregister(
			NotificationSettingsRepositoryProtocol.self,
			initializer: NotificationSettingsRepositoryImpl.init
		)
	}
}
