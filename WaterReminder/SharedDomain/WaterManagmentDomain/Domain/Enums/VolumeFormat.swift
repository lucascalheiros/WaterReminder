//
//  VolumeFormat.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 30/07/23.
//

import Foundation

enum VolumeFormat: Int, CaseIterable {
	case metric = 0
	case imperial_uk = 1
	case imperial_us = 2

	var formatDisplay: String {
		switch self {
		case .metric:
			return "ml"
		case .imperial_uk, .imperial_us:
			return "oz"
		}
	}

	var localizedDisplay: String {
		switch self {
		case .metric:
			return "ml"
		case .imperial_uk:
			return "oz UK"
		case .imperial_us:
			return "oz US"
		}
	}
}
