//
//  LocalePreferencesDomainAssembly.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 30/07/23.
//

import Swinject
import SwinjectAutoregistration

class LocalePreferencesDomainAssembly: Assembly {
	func assemble(container: Container) {
		container.autoregister(
			GetLocalePreferencesUseCase.self,
			initializer: GetLocalePreferencesUseCase.init
		)
		container.autoregister(
			ManageLocalePreferencesUseCase.self,
			initializer: ManageLocalePreferencesUseCase.init
		)
		container.autoregister(
			LocalePreferencesRepositoryProtocol.self,
			initializer: LocalePreferencesRepositoryImpl.init
		)
	}
}
