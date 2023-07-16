//
//  WaterManagementDomainAssembly.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 08/06/23.
//

import Swinject
import SwinjectAutoregistration

class WaterManagementDomainAssembly: Assembly {
	func assemble(container: Container) {
		container.autoregister(
			DailyWaterConsumptionRepositoryProtocol.self,
			initializer: DailyWaterConsumptionRepositoryImpl.init
		)
		container.autoregister(
			WaterSourceRepositoryProtocol.self,
			initializer: WaterSourceRepositoryImpl.init
		)
		container.autoregister(
			WaterConsumedRepositoryProtocol.self,
			initializer: WaterConsumedRepositoryImpl.init
		)
		container.autoregister(
			RegisterDailyWaterConsumptionUseCase.self,
			initializer: RegisterDailyWaterConsumptionUseCase.init
		)
		container.autoregister(
			GetDailyWaterConsumptionUseCase.self,
			initializer: GetDailyWaterConsumptionUseCase.init
		)
		container.autoregister(
			RegisterWaterConsumedUseCase.self,
			initializer: RegisterWaterConsumedUseCase.init
		)
		container.autoregister(
			ManageWaterSourceUseCase.self,
			initializer: ManageWaterSourceUseCase.init
		)
		container.autoregister(
			GetDailyWaterConsumptionUseCase.self,
			initializer: GetDailyWaterConsumptionUseCase.init
		)
		container.autoregister(
			GetWaterSourceUseCase.self,
			initializer: GetWaterSourceUseCase.init
		)
		container.autoregister(
			GetWaterConsumedUseCase.self,
			initializer: GetWaterConsumedUseCase.init
		)
	}
}
