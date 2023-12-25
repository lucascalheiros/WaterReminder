//
//  VolumeFormat+ExhibitionInfo.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 13/08/23.
//

import Foundation

public extension VolumeFormat {
    var formatDisplay: String {
		switch self {
		case .metric:
            return String(localized: "ml")
		case .imperial_uk, .imperial_us:
            return String(localized: "oz")
		}
	}

    var localizedDisplay: String {
		switch self {
		case .metric:
            return String(localized: "ml")
		case .imperial_uk:
            return String(localized: "oz UK")
		case .imperial_us:
            return String(localized: "oz US")
		}
	}

    var localizedFullDisplay: String {
        switch self {
        case .metric:
            return String(localized: "Metric")
        case .imperial_uk:
            return String(localized: "Imperial UK")
        case .imperial_us:
            return String(localized: "Imperial US")
        }
    }
}
