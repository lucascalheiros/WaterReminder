//
//  WeightFormat.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 28/05/23.
//

import Foundation

public enum WeightFormat: Int, CaseIterable, Codable {
	case metric = 0
	case imperial = 1
	
	public var displayString: String {
		switch self {
		case .metric:
			return "kg"
		case .imperial:
			return "lbs"
		}
	}
}
