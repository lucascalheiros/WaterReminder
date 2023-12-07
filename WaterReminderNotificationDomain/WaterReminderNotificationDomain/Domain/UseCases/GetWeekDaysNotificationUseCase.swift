//
//  GetNotificationWeekDaysStateUseCase.swift
//  WaterReminderNotificationDomain
//
//  Created by Lucas Calheiros on 02/12/23.
//

import Combine
import Common

public class GetWeekDaysNotificationUseCase {
    let notificationSettingsRepository: NotificationSettingsRepository

    init(
        notificationSettingsRepository: NotificationSettingsRepository
    ) {
        self.notificationSettingsRepository = notificationSettingsRepository
    }

    public func notificationWeekDaysState() -> any Publisher<[NotificationWeekDaysState], Never> {
        notificationSettingsRepository.notificationWeekDaysState.map { stateList in
            let stateDictionary = Dictionary(grouping: stateList, by: { $0.weekDay })
            return WeekDaysEnum.allCases.map { NotificationWeekDaysState($0, stateDictionary[$0]?.first?.enabled ?? true) }
        }
    }
}
