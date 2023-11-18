//
//  ThemeProtocol.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 17/11/23.
//

import Common
import UIKit

public protocol ThemeProtocol {
    var primary: ThemedColorProtocol { get }
    var secondary: ThemedColorProtocol { get }
    var error: ThemedColorProtocol { get }
    var surface: ThemedColorProtocol { get }
    var primaryVariant: ThemedColorProtocol { get }
    var secondaryVariant: ThemedColorProtocol { get }
    var background: ThemedColorProtocol { get }
}
