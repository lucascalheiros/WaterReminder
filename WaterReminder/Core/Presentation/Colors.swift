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
	case blue
	case darkGray
	case white
	case teal
	case primary
	case primaryDisabled
	case primaryBackground

    var accentColor: UIColor {
        switch self {
		case .lightBlue, .lightTeal, .white:
			return .darkGray
		case .blue, .darkGray, .teal, .primary, .primaryDisabled, .primaryBackground:
			return .white
        }
    }

    var mainColor: UIColor {
        UIColor(named: rawValue)!
    }

}
