//
//  RegisterUserInformationUseCase.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 08/06/23.
//

import Foundation

public class RegisterUserInformationUseCase {
	let userInformationRepository: UserInformationRepository

	internal init(userInformationRepository: UserInformationRepository) {
		self.userInformationRepository = userInformationRepository
	}

    public func execute(_ userInfo: UserInformation) async throws {
        try await userInformationRepository.saveUserInformation(userInfo)
    }
	
}
