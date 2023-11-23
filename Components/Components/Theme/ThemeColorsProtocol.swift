//
//  ThemeColorsProtocol.swift
//  Components
//
//  Created by Lucas Calheiros on 18/11/23.
//

import Common

public protocol ThemeColorsProtocol {
    var primary: ThemedColorProtocol { get }
    var secondary: ThemedColorProtocol { get }
    var error: ThemedColorProtocol { get }
    var surface: ThemedColorProtocol { get }
    var primaryVariant: ThemedColorProtocol { get }
    var secondaryVariant: ThemedColorProtocol { get }
    var background: ThemedColorProtocol { get }
}
