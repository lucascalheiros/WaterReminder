//
//  AddFixedNotificationViewModel.swift
//  Settings
//
//  Created by Lucas Calheiros on 02/12/23.
//

import Common
import WaterReminderNotificationDomain
import Combine

class AddFixedNotificationViewModel {
    let manageFixedNotificationsUseCase: ManageFixedNotificationsUseCase
    
    init(
        manageFixedNotificationsUseCase: ManageFixedNotificationsUseCase
        ) {
        self.manageFixedNotificationsUseCase = manageFixedNotificationsUseCase
    }

    func addFixedNotification(_ timePeriod: TimePeriod) {
        Task {
            do {
                try await manageFixedNotificationsUseCase.addFixedNotification(timePeriod: timePeriod)
            } catch {
                
            }
        }
    }
}
