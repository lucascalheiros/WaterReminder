//
//  ThemeRepositoryImpl.swift
//  UserInformationDomain
//
//  Created by Lucas Calheiros on 09/02/25.
//

import Combine
import Foundation

class ThemeRepositoryImpl: ThemeRepository {

    private static let themeKey = "ThemePreference@ThemeRepositoryImpl"

    private var themeSubject = CurrentValueSubject<ThemePreference, any Error>(ThemePreference(rawValue: UserDefaults.standard.string(forKey: themeKey) ?? "") ?? .auto)

    func getTheme() -> AnyPublisher<ThemePreference, any Error> {
        themeSubject.eraseToAnyPublisher()
    }
    
    func setTheme(_ theme: ThemePreference) async {
        UserDefaults.standard.set(theme.rawValue, forKey: ThemeRepositoryImpl.themeKey)
        themeSubject.value = theme
    }
}

