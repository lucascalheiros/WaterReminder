//
//  UserInformationDomainAssembly.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 08/06/23.
//

import Swinject
import SwinjectAutoregistration
import GRDB

public class UserInformationDomainAssembly: Assembly {

    public init() {}

	public func assemble(container: Container) {
        container.autoregister(
            DatabaseQueue.self,
            name: databaseFile,
            initializer: {
                try! getDatabase(databaseFile)
            }
        ).inObjectScope(.container)
		container.autoregister(
			UserInformationRepository.self,
            initializer: {
                UserInformationRepostoryImpl.init(container.resolve(DatabaseQueue.self, name: databaseFile)!)
            }
		)
		container.autoregister(
			GetExpectedWaterConsumptionUseCase.self,
			initializer: GetExpectedWaterConsumptionUseCase.init
		)
		container.autoregister(
			RegisterUserInformationUseCase.self,
			initializer: RegisterUserInformationUseCase.init
		)
        container.autoregister(
            GetCurrentThemePreferenceUseCase.self,
            initializer: GetCurrentThemePreferenceUseCase.init
        )
        container.autoregister(
            SetCurrentThemePreferenceUseCase.self,
            initializer: SetCurrentThemePreferenceUseCase.init
        )
        container.autoregister(
            GetUserProfileInfoUseCase.self,
            initializer: GetUserProfileInfoUseCase.init
        )
        container.autoregister(
            ThemeRepository.self,
            initializer: ThemeRepositoryImpl.init
        ).inObjectScope(.container)
	}
}


