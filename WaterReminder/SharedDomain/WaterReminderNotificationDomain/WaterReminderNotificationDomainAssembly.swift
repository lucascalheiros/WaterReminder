//
//  WaterReminderNotificationDomainAssembly.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 01/07/23.
//

import Swinject
import SwinjectAutoregistration

class WaterReminderNotificationDomainAssembly: Assembly {
	func assemble(container: Container) {
		container.autoregister(
			WaterReminderNotificationManager.self,
			initializer: WaterReminderNotificationManagerImpl.init
		)
		container.autoregister(
			ScheduleWaterReminderNotificationsUseCase.self,
			initializer: ScheduleWaterReminderNotificationsUseCase.init
		)
	}
}
