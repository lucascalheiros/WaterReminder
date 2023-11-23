//
//  AmbienceTemperatureLevel.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 02/07/23.
//

import Foundation

public enum AmbienceTemperatureLevel: CaseIterable {
	case cold
	case moderate
	case warn
	case hot

	var range: ClosedRange<Int> {
		get {
			switch (self) {
			case .cold:
				return Int.min ... 19
			case .moderate:
				return 20 ... 25
			case .warn:
				return 26 ... 30
			case .hot:
				return 31 ... Int.max
			}
		}
	}
}
