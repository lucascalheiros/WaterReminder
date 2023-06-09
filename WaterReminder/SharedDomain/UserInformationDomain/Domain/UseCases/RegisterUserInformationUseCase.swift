//
//  RegisterUserInformationUseCase.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 08/06/23.
//

import Foundation

class RegisterUserInformationUseCase {
	let userInformationRepository: UserInformationRepositoryProtocol

	internal init(userInformationRepository: UserInformationRepositoryProtocol) {
		self.userInformationRepository = userInformationRepository
	}

	
}
