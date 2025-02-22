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

		let request = UNNotificationRequest(
			identifier: waterReminderIdentifier(date: date),
			content: content,
			trigger: trigger
		)

		let notificationCenter = UNUserNotificationCenter.current()
		notificationCenter.add(request) { (error) in
			if error != nil {
				print(error?.localizedDescription ?? "")
			}
		}
        notificationCenter.getPendingNotificationRequests(completionHandler: { requests in
            for request in requests {
                print(request)
            }
        })
	}

	func removeReminder(reminderId: String) {
		let center = UNUserNotificationCenter.current()
		center.removePendingNotificationRequests(withIdentifiers: [reminderId])
		center.removeDeliveredNotifications(withIdentifiers: [reminderId])
	}

	func clearAllWaterReminderNotifications() async {
		let center = UNUserNotificationCenter.current()

        let pendingRequests = await center.pendingNotificationRequests()

        let pendingIdentifiers = pendingRequests
            .filter { $0.content.categoryIdentifier == WaterReminderNotificationManagerImpl.waterReminderCategory }
            .map { $0.identifier }

        center.removePendingNotificationRequests(withIdentifiers: pendingIdentifiers)

        let deliveredRequests = await center.deliveredNotifications()

        let deliveredIdentifiers = deliveredRequests
            .filter { $0.request.content.categoryIdentifier == WaterReminderNotificationManagerImpl.waterReminderCategory }
            .map { $0.request.identifier }

        center.removeDeliveredNotifications(withIdentifiers: deliveredIdentifiers)

	}
}
