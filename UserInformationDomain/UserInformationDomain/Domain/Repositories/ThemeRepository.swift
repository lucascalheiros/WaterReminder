//
//  ThemeRepository.swift
//  UserInformationDomain
//
//  Created by Lucas Calheiros on 09/02/25.
//

import Combine

protocol ThemeRepository {
    func getTheme() -> AnyPublisher<ThemePreference, any Error>
    func setTheme(_ theme: ThemePreference) async
}
