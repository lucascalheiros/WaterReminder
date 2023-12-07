//
//  NotificationFrequencyEnum.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 29/06/23.
//

import Foundation
import Common

public enum NotificationFrequencyEnum: Int, CaseIterable {
	case high
	case medium
	case low

    public func stringValue() -> String {
		switch self {
		case .high:
			return String(localized: "generic.high", table: "Notification")
		case .medium:
			return String(localized: "generic.medium", table: "Notification")
		case .low:
			return String(localized: "generic.low", table: "Notification")
		}
	}

	public func timePeriod() -> TimePeriod {
		switch (self) {
		case .high:
			return TimePeriod(hour: 1, minute: 30)
		case .medium:
			return TimePeriod(hour: 2)
		case .low:
			return TimePeriod(hour: 3)
		}
	}
}
