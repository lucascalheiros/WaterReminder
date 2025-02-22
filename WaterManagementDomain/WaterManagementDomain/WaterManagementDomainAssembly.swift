//
//  WaterManagementDomainAssembly.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 08/06/23.
//

import Swinject
import SwinjectAutoregistration
import GRDB

public class WaterManagementDomainAssembly: Assembly {
    public init() {}

    public func assemble(container: Container) {
        assembleRepositories(container)
        assembleUseCases(container)
    }

    func assembleRepositories(_ container: Container) {
        container.autoregister(
            DatabaseQueue.self,
            name: databaseFile,
            initializer: {
                return  try! getDatabase(databaseFile)
            }
        ).inObjectScope(.container)
        container.autoregister(
            DailyWaterConsumptionRepository.self,
            initializer: {
                DailyWaterConsumptionRepositoryImpl.init(dbQueue: container.resolve(DatabaseQueue.self, name: databaseFile)!)
            }
        )
        container.autoregister(
            WaterSourceRepository.self,
            initializer: {
                WaterSourceRepositoryImpl.init(dbQueue: container.resolve(DatabaseQueue.self, name: databaseFile)!)
            }
        )
        container.autoregister(
            WaterConsumedRepository.self,
            initializer: {
                WaterConsumedRepositoryImpl.init(dbQueue: container.resolve(DatabaseQueue.self, name: databaseFile)!)
            }
        )
        container.autoregister(
            VolumeFormatRepository.self,
            initializer: VolumeFormatRepositoryImpl.init
        )
        container.autoregister(
            DrinkRepository.self,
            initializer: {
                DrinkRepositoryImpl.init(dbQueue: container.resolve(DatabaseQueue.self, name: databaseFile)!)
            }
        )
    }

    func assembleUseCases(_ container: Container) {
        container.autoregister(
            RegisterDailyWaterConsumptionUseCase.self,
            initializer: RegisterDailyWaterConsumptionUseCase.init
        )
        container.autoregister(
            GetDailyWaterConsumptionUseCase.self,
            initializer: GetDailyWaterConsumptionUseCase.init
        )
        container.autoregister(
            DeleteWaterConsumedUseCase.self,
            initializer: DeleteWaterConsumedUseCase.init
        )
        container.autoregister(
            UpdateWaterSourceUseCase.self,
            initializer: UpdateWaterSourceUseCase.init
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
        container.autoregister(
            GetVolumeFormatUseCase.self,
            initializer: GetVolumeFormatUseCase.init
        )
        container.autoregister(
            RegisterVolumeFormatUseCase.self,
            initializer: RegisterVolumeFormatUseCase.init
        )
        container.autoregister(
            GetConsumptionSummaryUseCase.self,
            initializer: GetConsumptionSummaryUseCase.init
        )
        container.autoregister(
            GetDrinkUseCase.self,
            initializer: GetDrinkUseCase.init
        )
        container.autoregister(
            RegisterWaterConsumptionUseCase.self,
            initializer: RegisterWaterConsumptionUseCase.init
        )
        container.autoregister(
            CreateWaterSourceUseCase.self,
            initializer: CreateWaterSourceUseCase.init
        )
        container.autoregister(
            DeleteWaterSourceUseCase.self,
            initializer: DeleteWaterSourceUseCase.init
        )
        container.autoregister(
            CreateDrinkUseCase.self,
            initializer: CreateDrinkUseCase.init
        )
        container.autoregister(
            DeleteDrinkUseCase.self,
            initializer: DeleteDrinkUseCase.init
        )
    }
}

