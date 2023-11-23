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
        switch self {
        default:
            return UIColor(named: rawValue)!
        }
    }

    public var onColor: UIColor {
        switch self {
        default:
            return UIColor(named: "on" + rawValue.capitalized)!
        }
    }

    
}
