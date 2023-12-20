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
			DailyWaterConsumptionRepository.self,
			initializer: DailyWaterConsumptionRepositoryImpl.init
		)
		container.autoregister(
			WaterSourceRepository.self,
			initializer: WaterSourceRepositoryImpl.init
		)
		container.autoregister(
			WaterConsumedRepository.self,
			initializer: WaterConsumedRepositoryImpl.init
		)
		container.autoregister(
			VolumeFormatRepository.self,
			initializer: VolumeFormatRepositoryImpl.init
		)
	}

	func assembleUseCases(_ container: Container) {
		container.autoregister(
			RegisterDailyWaterConsumptionUseCase.self,
			initializer: RegisterDailyWaterConsumptionUseCaseImpl.init
		)
		container.autoregister(
			GetDailyWaterConsumptionUseCase.self,
			initializer: GetDailyWaterConsumptionUseCaseImpl.init
		)
		container.autoregister(
			ManageWaterConsumedUseCase.self,
			initializer: ManageWaterConsumedUseCaseImpl.init
		)
		container.autoregister(
			ManageWaterSourceUseCase.self,
			initializer: ManageWaterSourceUseCaseImpl.init
		)
		container.autoregister(
			GetDailyWaterConsumptionUseCase.self,
			initializer: GetDailyWaterConsumptionUseCaseImpl.init
		)
		container.autoregister(
			GetWaterSourceUseCase.self,
			initializer: GetWaterSourceUseCaseImpl.init
		)
		container.autoregister(
			GetWaterConsumedUseCase.self,
			initializer: GetWaterConsumedUseCaseImpl.init
		)
		container.autoregister(
			GetVolumeFormatUseCase.self,
			initializer: GetVolumeFormatUseCaseImpl.init
		)
        container.autoregister(
            RegisterVolumeFormatUseCase.self,
            initializer: RegisterVolumeFormatUseCaseImpl.init
        )
        container.autoregister(
            GetConsumedWaterPercentageUseCase.self,
			initializer: GetConsumedWaterPercentageUseCaseImpl.init
		)
	}
}
