//
//  GetUserInfoUseCase.swift
//  UserInformationDomain
//
//  Created by Lucas Calheiros on 09/02/25.
//

import Combine

public class GetUserProfileInfoUseCase {

    private let userInformationRepository: UserInformationRepository

    init(userInformationRepository: UserInformationRepository) {
        self.userInformationRepository = userInformationRepository
    }

    public func execute() -> AnyPublisher<UserInformation, any Error> {
        userInformationRepository.getUserInformationList().map {
            $0.sorted { $0.date < $1.date }.last
        }.compactMap { $0 }.eraseToAnyPublisher()
    }
}
