//
//  WeightFormat.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 28/05/23.
//

import Foundation

enum WeightFormat: Int, CaseIterable {
	case metric = 0
	case imperial = 1
	
	var displayString: String {
		switch self {
		case .metric:
			return "kg"
		case .imperial:
			return "lb"
		}
	}
}
