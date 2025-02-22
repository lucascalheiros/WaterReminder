//
//  FirstAccessInformationSharedViewModel.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 31/05/23.
//

import RxRelay
import RxSwift
import RxFlow
import Common
import WaterReminderNotificationDomain
import WaterManagementDomain
import UserInformationDomain
import Core
import Combine
import RxFlow

class FirstAccessInformationSharedViewModel {
	private let disposeBag = DisposeBag()

	private let expectedWaterConsumptionUseCase: GetExpectedWaterConsumptionUseCase
	private let registerDailyWaterConsumptionUseCase: RegisterDailyWaterConsumptionUseCase
	private let manageNotificationSettingsUseCase: ManageNotificationSettingsUseCase
    private let registerUserInformationUseCase: RegisterUserInformationUseCase

	let pageNavigationDelegate = FirstAccessInformationPageNavigationDelegate()

	let stepper: FirstAccessInformationStepper

	let timePeriodFifteenMinutesSpaced =  Array(0...23).flatMap { hour in
        Array(0...3).map { minute in TimePeriod(hour: hour, minute: minute * 15) }
	}

    @Published private(set) var activityLevel: ActivityLevel = .light
    @Published private(set) var temperatureLevel: AmbienceTemperatureLevel = .moderate
    @Published private(set) var weightInfo: WeightInfo = WeightInfo(weightInteger: 70, weightFraction: 0, weightFormat: WeightFormat.metric)
    @Published private(set) var shouldRemind: Bool = true
    @Published private(set) var initialTimeIndex: Int = 8 * 4
    @Published private(set) var finalTimeIndex: Int = 20 * 4
    @Published private(set) var currentVolume = Volume(0, .milliliters)

    lazy var scheduleNotificationOnConfirmEvent: PassthroughSubject<Bool, Never> = PassthroughSubject()

	lazy var userInformation = {
        $activityLevel.combineLatest($temperatureLevel, $weightInfo) {activityLevel, temperature, weight in
            UserInformation(
                id: nil,
                weightInGrams: weight.toGrams(),
                activityLevel: activityLevel,
                ambienceTemperatureLevel: temperature,
                date: Date()
            )
        }
	}()

    lazy var expectedWaterVolume: any Publisher<ExpectedWaterConsumptionState, Never> = {
		userInformation.map {
			self.expectedWaterConsumptionUseCase.calculateExpectedWaterConsumptionFromUserInformation($0)
        }.eraseToAnyPublisher()
	}()

	internal init(
		expectedWaterConsumptionUseCase: GetExpectedWaterConsumptionUseCase,
		registerDailyWaterConsumptionUseCase: RegisterDailyWaterConsumptionUseCase,
		manageNotificationSettingsUseCase: ManageNotificationSettingsUseCase,
        registerUserInformationUseCase: RegisterUserInformationUseCase,
		stepper: FirstAccessInformationStepper
	) {
		self.expectedWaterConsumptionUseCase = expectedWaterConsumptionUseCase
		self.registerDailyWaterConsumptionUseCase = registerDailyWaterConsumptionUseCase
        self.manageNotificationSettingsUseCase = manageNotificationSettingsUseCase
		self.registerUserInformationUseCase = registerUserInformationUseCase
		self.stepper = stepper
	}

    func setCurrentVolumeFormat(_ system: SystemFormat) {
        currentVolume = currentVolume.to(system)
    }

    func setCurrentVolume(_ value: Double) {
        currentVolume.value = value
    }

    func setShouldRemind(_ shouldRemind: Bool) {
        self.shouldRemind = shouldRemind
    }

    func setInitialTimeIndex(_ index: Int) {
        initialTimeIndex = index
    }

    func setFinalTimeIndex(_ index: Int) {
        finalTimeIndex = index
    }

    func setWeightInfo(_ weight: WeightInfo) {
        weightInfo = weight
    }

    func setActivityLevel(_ level: ActivityLevel) {
        activityLevel = level
    }

    func setTemperatureLevel(_ level: AmbienceTemperatureLevel) {
        temperatureLevel = level
    }

	func confirm() {
        Task {
            do {
                try await registerUserInformationUseCase.execute(
                    UserInformation(
                        id: nil,
                        weightInGrams: weightInfo.toGrams(),
                        activityLevel: activityLevel,
                        ambienceTemperatureLevel: temperatureLevel,
                        date: Date()
                    )
                )
                try await registerDailyWaterConsumptionUseCase.registerDailyWaterConsumption(waterValue: currentVolume.to(.milliliters).value.toInt())
                if self.shouldRemind {
                    self.scheduleNotificationOnConfirmEvent.send(true)
                } else {
                    self.completeProcess()
                }
            } catch {
                print(error)
            }
        }
	}

	func scheduleReminderNotifications() {
		let notificationSettings = NotificationSettings(
			isReminderEnabled: shouldRemind,
			notificationFrequency: .medium,
			startTime: timePeriodFifteenMinutesSpaced[initialTimeIndex],
			endTime: timePeriodFifteenMinutesSpaced[finalTimeIndex]
		)
		Task {
			do {
				try await manageNotificationSettingsUseCase.setNotificationSetting(notificationSettings)
			} catch {
                print(error)
			}
            self.completeProcess()
		}
	}

    func completeProcess() {
        self.stepper.steps.accept(FirstAccessFlowSteps.firstAccessUserInformationAlreadyProvided)
	}
}
