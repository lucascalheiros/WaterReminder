//
//  VolumeFormat+Conversion.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 03/08/23.
//

extension VolumeFormat {
	func toMetric(_ volume: Float) -> Float {
		switch self {
		case .metric:
			return volume
		case .imperial_uk:
			return volume * 28.413
		case .imperial_us:
			return volume * 29.573
		}
	}

	func fromMetric(_ volume: Float) -> Float {
		switch self {
		case .metric:
			return volume
		case .imperial_uk:
			return volume / 28.413
		case .imperial_us:
			return volume / 29.573
		}
	}
}
