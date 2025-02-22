//
//  SettingsViewModel.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 21/07/23.
//

import Combine
import WaterManagementDomain
import UserInformationDomain

class SettingsViewModel {
    let notificationReminderToggleDelegate: NotificationReminderToggleDelegate
    let dailyWaterSelectorDelegate: DailyWaterSelectorDelegate
    let periodSelectorDelegate: PeriodSelectorDelegate
    let notificationFrequencySelectorDelegate: NotificationFrequencySelectorDelegate
    let getCurrentThemePreferenceUseCase: GetCurrentThemePreferenceUseCase
    let setCurrentThemePreferenceUseCase: SetCurrentThemePreferenceUseCase
    let getUserProfileInfoUseCase: GetUserProfileInfoUseCase
    let registerUserInformationUseCase: RegisterUserInformationUseCase
    let getExpectedWaterConsumptionUseCase: GetExpectedWaterConsumptionUseCase
    let getVolumeFormatUseCase: GetVolumeFormatUseCase
    let registerDailyWaterConsumptionUseCase: RegisterDailyWaterConsumptionUseCase
    let settingsStepper: SettingsStepper

    private(set) lazy var theme = getCurrentThemePreferenceUseCase.execute().catchNever()

    private(set) lazy var weight = {
        getUserProfileInfoUseCase.execute().catchNever()
            .compactMap { $0.weightInGrams }
            .combineLatest(getVolumeFormatUseCase.execute()) { value, format in
                Weight(value, .grams).to(format)
            }
    }()

    private(set) lazy var activityLevel = getUserProfileInfoUseCase.execute().map { $0.activityLevel }

    private(set) lazy var temperature = getUserProfileInfoUseCase.execute().map { $0.ambienceTemperatureLevel }

    private(set) lazy var expectedWaterIntakeVolume = {
        getExpectedWaterConsumptionUseCase.getExpectedWaterConsumptionByCurrentUserInformation()
            .catchNever()
            .compactMap {
                if case .successful(let value) = $0 {
                    value
                } else {
                    nil
                }
            }
            .combineLatest(getVolumeFormatUseCase.execute()) { value, format in
                Volume(value, .milliliters).to(format)
            }
    }()

    init(
        notificationReminderToggleDelegate: NotificationReminderToggleDelegate,
        periodSelectorDelegate: PeriodSelectorDelegate,
        notificationFrequencySelectorDelegate: NotificationFrequencySelectorDelegate,
        dailyWaterSelectorDelegate: DailyWaterSelectorDelegate,
        getCurrentThemePreferenceUseCase: GetCurrentThemePreferenceUseCase,
        setCurrentThemePreferenceUseCase: SetCurrentThemePreferenceUseCase,
        getUserProfileInfoUseCase: GetUserProfileInfoUseCase,
        getExpectedWaterConsumptionUseCase: GetExpectedWaterConsumptionUseCase,
        getVolumeFormatUseCase: GetVolumeFormatUseCase,
        registerUserInformationUseCase: RegisterUserInformationUseCase,
        registerDailyWaterConsumptionUseCase: RegisterDailyWaterConsumptionUseCase,
        settingsStepper: SettingsStepper
    ) {
        self.notificationReminderToggleDelegate = notificationReminderToggleDelegate
        self.periodSelectorDelegate = periodSelectorDelegate
        self.notificationFrequencySelectorDelegate = notificationFrequencySelectorDelegate
        self.dailyWaterSelectorDelegate = dailyWaterSelectorDelegate
        self.settingsStepper = settingsStepper
        self.setCurrentThemePreferenceUseCase = setCurrentThemePreferenceUseCase
        self.getCurrentThemePreferenceUseCase = getCurrentThemePreferenceUseCase
        self.getUserProfileInfoUseCase = getUserProfileInfoUseCase
        self.getExpectedWaterConsumptionUseCase = getExpectedWaterConsumptionUseCase
        self.getVolumeFormatUseCase = getVolumeFormatUseCase
        self.registerUserInformationUseCase = registerUserInformationUseCase
        self.registerDailyWaterConsumptionUseCase = registerDailyWaterConsumptionUseCase
    }

    func setTheme(_ theme: ThemePreference) {
        Task {
            await setCurrentThemePreferenceUseCase.execute(theme)
        }
    }

    func presentNotificationManager() {
        settingsStepper.steps.accept(SettingsFlowSteps.manageNotifications)
    }

    func setWeight(_ weight: Weight) {
        Task {
            var userInfo = try await getUserProfileInfoUseCase.execute().awaitFirst()
            userInfo.weightInGrams = weight.to(.grams).value.toInt()
            try await registerUserInformationUseCase.execute(userInfo)
        }
    }

    func setActivityLevel(_ value: ActivityLevel) {
        Task {
            var userInfo = try await getUserProfileInfoUseCase.execute().awaitFirst()
            userInfo.activityLevel = value
            try await registerUserInformationUseCase.execute(userInfo)
        }
    }

    func setTemperatureLevel(_ value: AmbienceTemperatureLevel) {
        Task {
            var userInfo = try await getUserProfileInfoUseCase.execute().awaitFirst()
            userInfo.ambienceTemperatureLevel = value
            try await registerUserInformationUseCase.execute(userInfo)
        }
    }

    func setIntake(_ value: Volume) {
        Task {
            try await registerDailyWaterConsumptionUseCase.registerDailyWaterConsumption(waterValue: value.to(.milliliters).value.toInt())
        }
    }

}


extension Weight {

    public func to(_ system: SystemFormat) -> Weight {
        switch system {

        case .metric:
            to(.kilograms)

        case .imperial_uk, .imperial_us:
            to(.pounds)

        }
    }
}
