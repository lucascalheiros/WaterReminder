//
//  UserInformationRepository.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 04/06/23.
//

import Foundation
import Combine

protocol UserInformationRepository {
    func getUserInformationList() -> AnyPublisher<[UserInformation], any Error>
    func saveUserInformation(_ userInformation: UserInformation) async throws
}
