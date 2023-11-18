//
//  DefaultComponentsTheme.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 17/11/23.
//

import Foundation
import UIKit
import Common

public class DefaultComponentsTheme: ThemeProtocol {
    public var primary: ThemedColorProtocol = ThemedColor(color: .blue, onColor: .white)

    public var secondary: ThemedColorProtocol = ThemedColor(color: .systemTeal, onColor: .white)

    public var error: ThemedColorProtocol = ThemedColor(color: .systemTeal, onColor: .white)

    public var surface: ThemedColorProtocol = ThemedColor(color: .systemTeal, onColor: .white)

    public var primaryVariant: ThemedColorProtocol = ThemedColor(color: .systemTeal, onColor: .white)

    public var secondaryVariant: ThemedColorProtocol = ThemedColor(color: .systemTeal, onColor: .white)

    public var background: ThemedColorProtocol = ThemedColor(color: .systemTeal, onColor: .white)

    init() {}

}

extension DefaultComponentsTheme {
    public static var componentsTheme: ThemeProtocol = DefaultComponentsTheme()
}
