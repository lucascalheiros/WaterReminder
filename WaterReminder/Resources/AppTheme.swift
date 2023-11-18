//
//  AppTheme.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 17/11/23.
//

import Components
import Core
import Common

public class AppTheme: ThemeProtocol {
    public var primary: ThemedColorProtocol = AppColorGroup.primary

    public var secondary: ThemedColorProtocol = AppColorGroup.secondary

    public var error: ThemedColorProtocol = AppColorGroup.error

    public var surface: ThemedColorProtocol = AppColorGroup.surface

    public var primaryVariant: ThemedColorProtocol = AppColorGroup.primaryVariant

    public var secondaryVariant: ThemedColorProtocol = AppColorGroup.secondaryVariant

    public var background: ThemedColorProtocol = AppColorGroup.background

    init() {}

}
