//
//  WaterReminderNotificationManager.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 25/06/23.
//

import Foundation

protocol WaterReminderNotificationManager {
	func scheduleReminder(title: String, message: String, date: DateComponents)
	func removeReminder(reminderId: String)
	func clearAllWaterReminderNotifications()
}
