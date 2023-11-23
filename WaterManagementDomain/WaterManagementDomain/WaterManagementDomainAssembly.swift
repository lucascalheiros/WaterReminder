//
//  WaterManagementDomainAssembly.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 08/06/23.
//

import Swinject
import SwinjectAutoregistration

public class WaterManagementDomainAssembly: Assembly {
    public init() {}

	public func assemble(container: Container) {
		assembleRepositories(container)
		assembleUseCases(container)
	}

	func assembleRepositories(_ container: Container) {
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
			VolumeFormatRepositoryProtocol.self,
			initializer: VolumeFormatRepositoryImpl.init
		)
	}

	func assembleUseCases(_ container: Container) {
		container.autoregister(
			RegisterDailyWaterConsumptionUseCaseProtocol.self,
			initializer: RegisterDailyWaterConsumptionUseCase.init
		)
		container.autoregister(
			GetDailyWaterConsumptionUseCaseProtocol.self,
			initializer: GetDailyWaterConsumptionUseCase.init
		)
		container.autoregister(
			RegisterWaterConsumedUseCaseProtocol.self,
			initializer: RegisterWaterConsumedUseCase.init
		)
		container.autoregister(
			ManageWaterSourceUseCaseProtocol.self,
			initializer: ManageWaterSourceUseCase.init
		)
		container.autoregister(
			GetDailyWaterConsumptionUseCaseProtocol.self,
			initializer: GetDailyWaterConsumptionUseCase.init
		)
		container.autoregister(
			GetWaterSourceUseCaseProtocol.self,
			initializer: GetWaterSourceUseCase.init
		)
		container.autoregister(
			GetWaterConsumedUseCaseProtocol.self,
			initializer: GetWaterConsumedUseCase.init
		)
		container.autoregister(
			GetVolumeFormatUseCaseProtocol.self,
			initializer: GetVolumeFormatUseCase.init
		)
        container.autoregister(
            RegisterVolumeFormatUseCaseProtocol.self,
            initializer: RegisterVolumeFormatUseCase.init
        )
        container.autoregister(
            GetConsumedWaterPercentageUseCase.self,
			initializer: GetConsumedWaterPercentageUseCaseImpl.init
		)
	}
}
