//
//  DateExt.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 18/06/23.
//

import Foundation

public extension Date {
	var startOfDay: Date {
		return Calendar.current.startOfDay(for: self)
	}
	
	var endOfDay: Date {
		var components = DateComponents()
		components.day = 1
		components.second = -1
		return Calendar.current.date(byAdding: components, to: startOfDay)!
	}
}
