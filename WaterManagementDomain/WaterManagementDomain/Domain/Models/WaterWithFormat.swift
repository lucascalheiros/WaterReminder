//
//  WaterWithFormat.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 06/08/23.
//

import Foundation

public struct WaterWithFormat {
    public let waterInML: Int
    public let volumeFormat: VolumeFormat

    public init(waterInML: Int, volumeFormat: VolumeFormat) {
        self.waterInML = waterInML
        self.volumeFormat = volumeFormat
    }

	public func exhibitionValue() -> String {
		let formattedValue = volumeFormat.fromMetric(Float(waterInML))
		switch volumeFormat {
		case .metric:
			return "\(String(format: "%.0f", formattedValue))"

		default:
			return "\(String(format: "%.2f", formattedValue))"
		}
	}

	public func exhibitionValueWithFormat() -> String {
		return "\(exhibitionValue()) \(volumeFormat.formatDisplay)"
	}
}
