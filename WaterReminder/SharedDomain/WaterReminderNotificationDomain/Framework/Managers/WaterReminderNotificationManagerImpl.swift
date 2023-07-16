//
//  WaterReminderNotificationManagerImpl.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 28/06/23.
//

import UIKit

class WaterReminderNotificationManagerImpl: WaterReminderNotificationManager {
	private static let waterReminderCategory = "WATER_REMINDER_CATEGORY"

	private func waterReminderIdentifier(date: DateComponents) -> String {
		let hour = date.hour ?? 0
		let minute = date.minute ?? 0
		return "\(WaterReminderNotificationManagerImpl.waterReminderCategory)_\(hour)_\(minute)"
	}

	func scheduleReminder(title: String, message: String, date: DateComponents) {
		let content = UNMutableNotificationContent()
		content.title = title
		content.body = message
		content.categoryIdentifier = WaterReminderNotificationManagerImpl.waterReminderCategory

		let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)

		let request = UNNotificationRequest(identifier: waterReminderIdentifier(date: date),
											content: content, trigger: trigger)

		let notificationCenter = UNUserNotificationCenter.current()
		notificationCenter.add(request) { (error) in
			if error != nil {
				print(error?.localizedDescription ?? "")
			}
		}
	}

	func removeReminder(reminderId: String) {
		let center = UNUserNotificationCenter.current()
		center.removePendingNotificationRequests(withIdentifiers: [reminderId])
		center.removeDeliveredNotifications(withIdentifiers: [reminderId])
	}

	func clearAllWaterReminderNotifications() {
		let center = UNUserNotificationCenter.current()

		center.getPendingNotificationRequests { (requests) in
			let filteredRequests = requests.filter { $0.content.categoryIdentifier == WaterReminderNotificationManagerImpl.waterReminderCategory }

			let identifiers = filteredRequests.map { $0.identifier }

			center.removePendingNotificationRequests(withIdentifiers: identifiers)
		}

		center.getDeliveredNotifications { (requests) in
			let filteredRequests = requests.filter { $0.request.content.categoryIdentifier == WaterReminderNotificationManagerImpl.waterReminderCategory }

			let identifiers = filteredRequests.map { $0.request.identifier }

			center.removeDeliveredNotifications(withIdentifiers: identifiers)
		}
	}
}
