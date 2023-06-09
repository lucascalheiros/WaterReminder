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
		container.autoregister(
			FirstAccessInformationSharedViewModel.self,
			initializer: FirstAccessInformationSharedViewModel.init
		)
		container.autoregister(
			FirstAccessPageViewController.self
		) {
			return FirstAccessPageViewController(
				pageProvider: container.resolve(FirstAccessPageProvider.self)!,
				firstAccessInformationViewModel: container.resolve(FirstAccessInformationSharedViewModel.self)!
			)
		}
		container.autoregister(
			FirstAccessPageProvider.self,
			initializer: FirstAccessPageProvider.init
		)
		container.autoregister(
			ActivityLevelInputViewController.self
		) {
			return ActivityLevelInputViewController(
				firstAccessInformationViewModel: container.resolve(FirstAccessInformationSharedViewModel.self)!
			)
		}
		container.autoregister(
			AmbienceTemperatureInputViewController.self
		) {
			return AmbienceTemperatureInputViewController(
				firstAccessInformationViewModel: container.resolve(FirstAccessInformationSharedViewModel.self)!
			)
		}
		container.autoregister(
			ConfirmationDailyConsumptionViewController.self
		) {
			return ConfirmationDailyConsumptionViewController(
				firstAccessInformationViewModel: container.resolve(FirstAccessInformationSharedViewModel.self)!
			)
		}
		container.autoregister(
			FirstAccessInformativeViewController.self
		) {
			return FirstAccessInformativeViewController(
				firstAccessInformationViewModel: container.resolve(FirstAccessInformationSharedViewModel.self)!
			)
		}
		container.autoregister(
			WeightInputViewController.self
		) {
			return WeightInputViewController(
				firstAccessInformationViewModel: container.resolve(FirstAccessInformationSharedViewModel.self)!
			)
		}

	}
}

extension ObjectScope {
	static let firstAccessFlowScope = ObjectScope(storageFactory: PermanentStorage.init)
}
