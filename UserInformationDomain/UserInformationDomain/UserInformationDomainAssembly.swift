//
//  UserInformationDomainAssembly.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 08/06/23.
//

import Swinject
import SwinjectAutoregistration

public class UserInformationDomainAssembly: Assembly {

    public init() {}

	public func assemble(container: Container) {
		container.autoregister(
			UserInformationRepository.self,
			initializer: UserInformationRepostoryImpl.init
		)
		container.autoregister(
			GetExpectedWaterConsumptionUseCase.self,
			initializer: GetExpectedWaterConsumptionUseCase.init
		)
		container.autoregister(
			RegisterUserInformationUseCase.self,
			initializer: RegisterUserInformationUseCase.init
		)
	}
}


