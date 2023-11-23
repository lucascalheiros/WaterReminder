//
//  FirstAccessInformationContainer.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 03/06/23.
//

import Foundation
import Swinject
import SwinjectAutoregistration

public class FirstAccessInformationAssembly: Assembly {
    public init() {}

	public func assemble(container: Container) {
		container.autoregister(
            FirstAccessInformationStepper.self,
            initializer: FirstAccessInformationStepper.init
        ).inObjectScope(.weak) // While a flow has this reference the same instance will be injected 
		container.autoregister(
			FirstAccessInformationSharedViewModel.self,
			initializer: FirstAccessInformationSharedViewModel.init
		)
		container.autoregister(
			FirstAccessPageVC.self,
            initializer: FirstAccessPageVC.newInstance
		)
		container.autoregister(
            PageProviderProtocol.self,
			initializer: FirstAccessPageProvider.init
		)
		container.autoregister(
			ActivityLevelInputVC.self,
            initializer: ActivityLevelInputVC.newInstance
		)
		container.autoregister(
			AmbienceTemperatureInputVC.self,
            initializer: AmbienceTemperatureInputVC.newInstance
        )
		container.autoregister(
			ConfirmationDailyConsumptionVC.self,
            initializer: ConfirmationDailyConsumptionVC.newInstance
        )
		container.autoregister(
			FirstAccessInformativeVC.self,
            initializer: FirstAccessInformativeVC.newInstance
        )
		container.autoregister(
			WeightInputVC.self,
            initializer: WeightInputVC.newInstance
        )
	}
}

extension ObjectScope {
	static let firstAccessFlowScope = ObjectScope(storageFactory: PermanentStorage.init)
}
