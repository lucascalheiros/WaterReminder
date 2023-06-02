//
//  Colors.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 16/05/23.
//

import Foundation
import UIKit

enum Theme: String {

    case lightBlue
    case lightTeal

    var accentColor: UIColor {
        switch self {
        case .lightBlue, .lightTeal: return .darkGray
        }
    }

    var mainColor: UIColor? {
        UIColor(named: rawValue)
    }

}
