//
//  HomeAssembly.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 18/06/23.
//

import Swinject
import SwinjectAutoregistration

class HomeAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(
            HomeVC.self
        ) {
            return HomeVC(viewModel: container.resolve(HomeViewModel.self)!)
        }
        container.autoregister(
            EditWaterSourceListVC.self
        ) {
            return EditWaterSourceListVC(
                getWaterSourceUseCase: container.resolve(GetWaterSourceUseCaseProtocol.self)!,
                reorderWaterSourceUseCase: container.resolve(ReorderWaterSourceUseCase.self)!,
                manageWaterSourceUseCase: container.resolve(ManageWaterSourceUseCaseProtocol.self)!
            )
        }
        container.autoregister(HomeViewModel.self, initializer: HomeViewModel.init)
        container.autoregister(HomeFlowStepper.self, initializer: HomeFlowStepper.init).inObjectScope(.container)

        container.autoregister(ReorderWaterSourceUseCase.self, initializer: ReorderWaterSourceUseCaseImpl.init)
    }
}
