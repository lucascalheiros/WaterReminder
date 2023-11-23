//
//  AppTheme.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 17/11/23.
//

import Components
import Core
import Common
import UIKit

public class AppTheme: ThemeProtocol {
    public var h1: UIFont = .h1

    public var h2: UIFont = .h2

    public var h3: UIFont = .h3

    public var h4: UIFont = .h4

    public var body: UIFont = .body

    public var caption: UIFont = .caption

    public var screenTitle: UIFont = .screenTitle

    public var sectionTitle: UIFont = .sectionTitle

    public var buttonBig: UIFont = .buttonBig

    public var buttonDefault: UIFont = .buttonDefault

    public var primary: ThemedColorProtocol = AppColorGroup.primary

    public var secondary: ThemedColorProtocol = AppColorGroup.secondary

    public var error: ThemedColorProtocol = AppColorGroup.error

    public var surface: ThemedColorProtocol = AppColorGroup.surface

    public var primaryVariant: ThemedColorProtocol = AppColorGroup.primaryVariant

    public var secondaryVariant: ThemedColorProtocol = AppColorGroup.secondaryVariant

    public var background: ThemedColorProtocol = AppColorGroup.background

    init() {}

}
