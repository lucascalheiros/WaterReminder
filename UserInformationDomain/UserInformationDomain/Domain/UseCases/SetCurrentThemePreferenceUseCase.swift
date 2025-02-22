//
//  SetCurrentThemePreferenceUseCase.swift
//  UserInformationDomain
//
//  Created by Lucas Calheiros on 09/02/25.
//

public class SetCurrentThemePreferenceUseCase {

    private let themeRepository: ThemeRepository

    init(
        themeRepository: ThemeRepository
    ) {
        self.themeRepository = themeRepository
    }

    public func execute(_ theme: ThemePreference) async {
        await themeRepository.setTheme(theme)
    }
}
