//
//  ManageNotificationsViewModel.swift
//  Settings
//
//  Created by Lucas Calheiros on 28/11/23.
//

import Common
import WaterReminderNotificationDomain
import Combine

class ManageNotificationsViewModel {
    var cancellableBag = Set<AnyCancellable>()

    @Published var fixedNotification: [FixedNotificationUIModel] = []
    @Published var weekDaysState: [WeekDayUIModel] = []

    var fixedNotificationUIState: [Int:FixedNotificationUIModel] = [:]
    var weekDayUIState: [Int:WeekDayUIModel] = [:]

    let settingsStepper: SettingsStepper
    let getFixedNotificationsUseCase: GetFixedNotificationsUseCase
    let getNotificationWeekDaysStateUseCase: GetWeekDaysNotificationUseCase
    let manageWeekDaysNotificationUseCase: ManageWeekDaysNotificationUseCase
    let manageFixedNotificationsUseCase: ManageFixedNotificationsUseCase

    init(
        settingsStepper: SettingsStepper,
        getFixedNotificationsUseCase: GetFixedNotificationsUseCase,
        getNotificationWeekDaysStateUseCase: GetWeekDaysNotificationUseCase,
        manageWeekDaysNotificationUseCase: ManageWeekDaysNotificationUseCase,
        manageFixedNotificationsUseCase: ManageFixedNotificationsUseCase
    ) {
        self.settingsStepper = settingsStepper
        self.getFixedNotificationsUseCase = getFixedNotificationsUseCase
        self.getNotificationWeekDaysStateUseCase = getNotificationWeekDaysStateUseCase
        self.manageWeekDaysNotificationUseCase = manageWeekDaysNotificationUseCase
        self.manageFixedNotificationsUseCase = manageFixedNotificationsUseCase

        self.getNotificationWeekDaysStateUseCase.notificationWeekDaysState().sink {
            $0.forEach {
                let weekDayRaw = $0.weekDay.rawValue
                let uiModel = self.weekDayUIState[weekDayRaw] ?? WeekDayUIModel($0)
                self.weekDayUIState[weekDayRaw] = uiModel
            }
            self.weekDaysState = WeekDaysEnum.allCases.map {
                let weekDayRaw = $0.rawValue
                let uiModel = self.weekDayUIState[weekDayRaw] ?? WeekDayUIModel($0, true)
                self.weekDayUIState[weekDayRaw] = uiModel
                return uiModel
            }
        }.store(in: &cancellableBag)
        self.getFixedNotificationsUseCase.fixedNotifications().sink {
            self.fixedNotification =  $0
                .sorted(by: { $0.timePeriod < $1.timePeriod })
                .map {
                    let timePeriodInSec = $0.timePeriod.inSeconds()
                    let uiModel = self.fixedNotificationUIState[timePeriodInSec] ?? FixedNotificationUIModel($0)
                    self.fixedNotificationUIState[timePeriodInSec] = uiModel
                    return uiModel
                }
        }.store(in: &cancellableBag)
    }

    func addFixedNotification() {
        settingsStepper.steps.accept(SettingsFlowSteps.addFixedNotification)
    }

    func saveWeekDayState(_ weekDayState: NotificationWeekDaysState) {
        Task {
            do {
                try await manageWeekDaysNotificationUseCase.saveWeekDayNotificationState(weekDayState)
            } catch {

            }
        }
    }

    func saveFixedNotificationState(_ fixedNotificationState: FixedNotifications) {
        Task {
            do {
                try await manageFixedNotificationsUseCase.saveFixedNotification(_:)(fixedNotificationState)
            } catch {

            }
        }
    }

    func deleteFixedNotification(_ timePeriod: TimePeriod) {
        Task {
            do {
                fixedNotificationUIState.removeValue(forKey: timePeriod.inSeconds())
                try await manageFixedNotificationsUseCase.removeFixedNotification(timePeriod: timePeriod)
            } catch {

            }
        }
    }

}

class WeekDayUIModel: Hashable {

    let weekDay: WeekDaysEnum
    var enabled: Bool

    init(_ weekDay: WeekDaysEnum, _ enabled: Bool) {
        self.weekDay = weekDay
        self.enabled = enabled
    }

    init(_ state: NotificationWeekDaysState) {
        self.weekDay = state.weekDay
        self.enabled = state.enabled
    }

    static func == (lhs: WeekDayUIModel, rhs: WeekDayUIModel) -> Bool {
        lhs.weekDay == rhs.weekDay && lhs.enabled == rhs.enabled
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }

}


class FixedNotificationUIModel: Hashable {

    let timePeriod: TimePeriod
    var enabled: Bool

    init(_ fixedNotification: FixedNotifications) {
        self.timePeriod = fixedNotification.timePeriod
        self.enabled = fixedNotification.enabled
    }

    static func == (lhs: FixedNotificationUIModel, rhs: FixedNotificationUIModel) -> Bool {
        lhs.timePeriod == rhs.timePeriod && lhs.enabled == rhs.enabled
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }

}
