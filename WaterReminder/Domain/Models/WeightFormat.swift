//
//  WeightFormat.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 28/05/23.
//

import Foundation

enum WeightFormat: CaseIterable {
	case metric
	case imperial
	
	var displayString: String {
		switch self {
		case .metric:
			return "kg"
		case .imperial:
			return "lb"
		}
	}
}
