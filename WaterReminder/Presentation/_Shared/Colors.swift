//
//  Colors.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 16/05/23.
//

import Foundation
import UIKit


enum Theme: String {
    
    case LightBlue
    case LightTeal
    
    var accentColor: UIColor {
        switch self {
        case .LightBlue, .LightTeal: return .darkGray
        }
    }
    
    var mainColor: UIColor? {
        UIColor(named: rawValue)
    }
    
}
