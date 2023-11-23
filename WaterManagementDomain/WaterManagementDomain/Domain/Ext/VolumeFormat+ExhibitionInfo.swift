//
//  VolumeFormat+ExhibitionInfo.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 13/08/23.
//

import Foundation

public extension VolumeFormat {
	public var formatDisplay: String {
		switch self {
		case .metric:
			return "ml"
		case .imperial_uk, .imperial_us:
			return "oz"
		}
	}

	public var localizedDisplay: String {
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
