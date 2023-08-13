//
//  WaterWithFormat.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 06/08/23.
//

import Foundation

struct WaterWithFormat {
	let waterInML: Int
	let volumeFormat: VolumeFormat

	func exhibitionValue() -> String {
		let formattedValue = volumeFormat.fromMetric(Float(waterInML))
		switch volumeFormat {
		case .metric:
			return "\(String(format: "%.0f", formattedValue))"

		default:
			return "\(String(format: "%.2f", formattedValue))"
		}
	}

	func exhibitionValueWithFormat() -> String {
		return "\(exhibitionValue()) \(volumeFormat.formatDisplay)"
	}
}
