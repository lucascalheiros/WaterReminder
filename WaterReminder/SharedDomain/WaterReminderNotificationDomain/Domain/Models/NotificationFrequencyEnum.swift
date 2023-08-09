//
//  NotificationFrequencyEnum.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 29/06/23.
//

import Foundation

enum NotificationFrequencyEnum: Int, CaseIterable {
	case high
	case medium
	case low

	func stringValue() -> String {
		switch self {
		case .high:
			return "High"
		case .medium:
			return "Medium"
		case .low:
			return "Low"
		}
	}
}
