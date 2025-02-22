//
//  AppColorGroup.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 10/11/23.
//

import Foundation
import UIKit
import Common

public enum AppColorGroup: String, CaseIterable, ThemedColorProtocol {

    case primary
    case secondary
    case error
    case surface
    case primaryVariant
    case secondaryVariant
    case background

    public var color: UIColor {
        return loadColor(named: rawValue)
    }

    public var onColor: UIColor {
        return loadColor(named: "on" + rawValue.capitalized)
    }

    private func loadColor(named name: String) -> UIColor {
        guard let color = UIColor(named: name) else {
            return .clear
        }
        return color
    }
}

