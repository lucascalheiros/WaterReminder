//
//  HomeAssembly.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 18/06/23.
//

import Swinject
import SwinjectAutoregistration
import WaterManagementDomain

public class HomeAssembly: Assembly {
    public init() {}

    public func assemble(container: Container) {
        container.autoregister(
            HomeVC.self,
            initializer: HomeVC.newInstance
        )
        container.autoregister(
            EditWaterSourceListVC.self,
            initializer: EditWaterSourceListVC.newInstance
        )
        container.autoregister(
            HomeViewModel.self,
            initializer: HomeViewModel.init
        )
        container.autoregister(
            HomeFlowStepper.self,
            initializer: HomeFlowStepper.init
        ).inObjectScope(.weak)
        container.autoregister(
            ReorderWaterSourceUseCase.self,
            initializer: ReorderWaterSourceUseCaseImpl.init
        )
        container.autoregister(
            CreateWaterSourceItemVC.self, 
            initializer: CreateWaterSourceItemVC.newInstance
        )
        container.autoregister(
            CreateWaterSourceItemViewModel.self,
            initializer: CreateWaterSourceItemViewModel.init
        )
        container.autoregister(
            EditWaterSourceListViewModel.self,
            initializer: EditWaterSourceListViewModel.init)
    }
}
