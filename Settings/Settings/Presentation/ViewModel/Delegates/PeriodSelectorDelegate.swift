//
//  PeriodSelectorDelegate.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 29/07/23.
//

import Combine
import Common
import WaterReminderNotificationDomain

class PeriodSelectorDelegate {
    let getNotificationSettingsUseCase: GetNotificationSettingsUseCase
    let manageNotificationSettingsUseCase: ManageNotificationSettingsUseCase

    lazy var periodInterval = initialTime.combineLatest(finalTime).map {
        $0.hourAndMinuteAsString() + "-" + $1.hourAndMinuteAsString()
    }

    lazy var initialTime = getNotificationSettingsUseCase.notificationStartTime()
    lazy var finalTime = getNotificationSettingsUseCase.notificationEndTime()

    init(getNotificationSettingsUseCase: GetNotificationSettingsUseCase, manageNotificationSettingsUseCase: ManageNotificationSettingsUseCase) {
        self.getNotificationSettingsUseCase = getNotificationSettingsUseCase
        self.manageNotificationSettingsUseCase = manageNotificationSettingsUseCase
    }

    func setNotificationPeriod(startTime: TimePeriod, endTime: TimePeriod) {
        Task {
            do {
                let zipped = self.getNotificationSettingsUseCase.isReminderNotificationEnabled().zip(
                    self.getNotificationSettingsUseCase.notificationFrequency()
                    )
                for await (isEnabled, frequency) in zipped.values {
                    try await self.manageNotificationSettingsUseCase.setNotificationSetting(
                        NotificationSettings(
                            isReminderEnabled: isEnabled,
                            notificationFrequency: frequency,
                            startTime: startTime,
                            endTime: endTime
                            )
                        )
                }
            } catch {
                
            }
        }
    }

}
