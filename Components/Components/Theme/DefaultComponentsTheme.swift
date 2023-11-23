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

    public var h1: UIFont {
        .boldSystemFont(ofSize: 40)
    }

    public var h2: UIFont {
        .boldSystemFont(ofSize: 30)
    }

    public var h3: UIFont {
        .boldSystemFont(ofSize: 25)
    }

    public var h4: UIFont {
        .boldSystemFont(ofSize: 20)
    }

    public var body: UIFont {
        .boldSystemFont(ofSize: 16)
    }

    public var caption: UIFont {
        .boldSystemFont(ofSize: 15)
    }

    public var screenTitle: UIFont {
        .h4
    }

    public var sectionTitle: UIFont {
        .h4
    }

    public var buttonBig: UIFont {
        .h4
    }

    public var buttonDefault: UIFont {
        .body
    }


    init() {}

}

extension DefaultComponentsTheme {
    public static var current: ThemeProtocol = DefaultComponentsTheme()
}
