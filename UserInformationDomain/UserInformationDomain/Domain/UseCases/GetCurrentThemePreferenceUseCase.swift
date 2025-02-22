//
//  GetCurrentThemePreferenceUseCase.swift
//  UserInformationDomain
//
//  Created by Lucas Calheiros on 09/02/25.
//

import Combine

public class GetCurrentThemePreferenceUseCase {

    private let themeRepository: ThemeRepository

    init(themeRepository: ThemeRepository) {
        self.themeRepository = themeRepository
    }

    public func execute() -> AnyPublisher<ThemePreference, any Error> {
        themeRepository.getTheme()
    }
}
