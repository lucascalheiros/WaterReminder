//
//  AppColorGroup.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 10/11/23.
//

import Foundation
import UIKit

public enum AppColorGroup: String, CaseIterable {

    case primary
    case secondary
    case error
    case surface

    case primaryVariant
    case secondaryVariant

    case background

    case primaryContainer
    case secondaryContainer
    case errorContainer

    public var color: UIColor {
        switch self {
        default:
            return UIColor(named: rawValue)!
        }
    }

    public var onColor: UIColor {
        switch self {
        case .surface:
            return UIColor(named: "onSurface")!
        default:
            return .white
        }
    }

    public var onColorVariant: UIColor {
        switch self {
        default:
            return .white
        }
    }
    
}
