//
//  WaterSourceType+ExhibitionInfo.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 13/08/23.
//

import UIKit

extension WaterSourceType {
	var color: UIColor {
		switch self {
		case .water:
			return UIColor.blue
		case .coffee:
			return UIColor.brown
		case .juice:
			return UIColor.orange
		case .tea:
			return UIColor.green
		case .soda:
			return UIColor.cyan
		}
	}

	var exhibitionName: String {
		switch self {
		case .water:
			return "Water"
		case .coffee:
			return "Coffee"
		case .juice:
			return "Juice"
		case .tea:
			return "Tea"
		case .soda:
			return "Soda"
		}
	}

    var order: Int {
        switch self {
        case .water:
            return 0
        case .coffee:
            return 1
        case .juice:
            return 2
        case .tea:
            return 3
        case .soda:
            return 4
        }
    }
}
