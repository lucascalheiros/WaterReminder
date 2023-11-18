//
//  FirstAccessInformationContainer.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 03/06/23.
//

import Foundation
import Swinject
import SwinjectAutoregistration

class FirstAccessInformationAssembly: Assembly {
	func assemble(container: Container) {
		container.autoregister(FirstAccessInformationStepper.self, initializer: FirstAccessInformationStepper.init).inObjectScope(.container)
		container.autoregister(
			FirstAccessInformationSharedViewModel.self,
			initializer: FirstAccessInformationSharedViewModel.init
		)
		container.autoregister(
			FirstAccessPageVC.self
		) {
			return FirstAccessPageVC(
				pageProvider: container.resolve(FirstAccessPageProvider.self)!,
				firstAccessInformationViewModel: container.resolve(FirstAccessInformationSharedViewModel.self)!
			)
		}
		container.autoregister(
			FirstAccessPageProvider.self,
			initializer: FirstAccessPageProvider.init
		)
		container.autoregister(
			ActivityLevelInputVC.self
		) {
			return ActivityLevelInputVC(
				firstAccessInformationViewModel: container.resolve(FirstAccessInformationSharedViewModel.self)!
			)
		}
		container.autoregister(
			AmbienceTemperatureInputVC.self
		) {
			return AmbienceTemperatureInputVC(
				firstAccessInformationViewModel: container.resolve(FirstAccessInformationSharedViewModel.self)!
			)
		}
		container.autoregister(
			ConfirmationDailyConsumptionVC.self
		) {
			return ConfirmationDailyConsumptionVC(
				firstAccessInformationViewModel: container.resolve(FirstAccessInformationSharedViewModel.self)!
			)
		}
		container.autoregister(
			FirstAccessInformativeVC.self
		) {
			return FirstAccessInformativeVC(
				firstAccessInformationViewModel: container.resolve(FirstAccessInformationSharedViewModel.self)!
			)
		}
		container.autoregister(
			WeightInputVC.self
		) {
			return WeightInputVC(
				firstAccessInformationViewModel: container.resolve(FirstAccessInformationSharedViewModel.self)!
			)
		}

	}
}

extension ObjectScope {
	static let firstAccessFlowScope = ObjectScope(storageFactory: PermanentStorage.init)
}
