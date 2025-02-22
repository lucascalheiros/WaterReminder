//
//  SystemFormat.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 30/07/23.
//

import Foundation

public enum SystemFormat: Int, CaseIterable, Codable {
	case metric = 0
	case imperial_uk = 1
	case imperial_us = 2

    public var unit: VolumeUnit {
        switch self {

        case .metric:
                .milliliters
        case .imperial_uk:
                .oz_uk
        case .imperial_us:
                .oz_us
        }
    }
}
