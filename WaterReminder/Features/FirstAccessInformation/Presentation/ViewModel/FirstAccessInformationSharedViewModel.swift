//
//  FirstAccessInformationSharedViewModel.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 31/05/23.
//

import Foundation
import RxRelay
import RxSwift
import RxFlow

class FirstAccessInformationSharedViewModel {
	private let disposeBag = DisposeBag()
	private let expectedWaterConsumptionUseCase: GetExpectedWaterConsumptionUseCase
	private let registerDailyWaterConsumptionUseCase: RegisterDailyWaterConsumptionUseCase
	private let manageNotificationSettingsUseCase: ManageNotificationSettingsUseCase

	let pageNavigationDelegate = FirstAccessInformationPageNavigationDelegate()

	let stepper: FirstAccessInformationStepper

	let timePeriodFifteenMinutesSpaced =  Array(0...23).flatMap { hour in
		Array(0...3).map { minute in TimePeriod(hour: hour, minute: minute * 15) }
	}

	lazy var exerciseDays: BehaviorRelay<Float> = BehaviorRelay(value: 3.0)
	lazy var temperatureLevel = BehaviorRelay(value: AmbienceTemperatureLevel.moderate)
	lazy var weightInfo = BehaviorRelay(value: WeightInfo(weightInteger: 70, weightFraction: 0, weightFormat: WeightFormat.metric))
	lazy var shouldRemind = BehaviorRelay(value: true)
	lazy var initialTimeIndex = BehaviorRelay(value: 8 * 4)
	lazy var finalTimeIndex = BehaviorRelay(value: 20 * 4)
	lazy var scheduleNotificationOnConfirmEvent: PublishRelay<Bool> = PublishRelay()

	lazy var userInformation = {
		Observable.combineLatest(
			weightInfo.asObservable(),
			exerciseDays.asObservable(),
			temperatureLevel.asObservable()
		) { weight, exerciseDays, temperatureLevel in
			UserInformation(id: nil, weightInGrams: weight.toGrams(), activityLevelInWeekDays: Int(exerciseDays), ambienceTemperatureLevel: temperatureLevel, date: Date() )
		}
	}()

	lazy var expectedWaterVolume: Observable<ExpectedWaterConsumptionState> = {
		userInformation.map {
			self.expectedWaterConsumptionUseCase.calculateExpectedWaterConsumptionFromUserInformation($0)
		}
	}()

	internal init(
		expectedWaterConsumptionUseCase: GetExpectedWaterConsumptionUseCase,
		registerDailyWaterConsumptionUseCase: RegisterDailyWaterConsumptionUseCase,
		manageNotificationSettingsUseCase: ManageNotificationSettingsUseCase,
		stepper: FirstAccessInformationStepper
	) {
		self.expectedWaterConsumptionUseCase = expectedWaterConsumptionUseCase
		self.registerDailyWaterConsumptionUseCase = registerDailyWaterConsumptionUseCase
		self.manageNotificationSettingsUseCase = manageNotificationSettingsUseCase
		self.stepper = stepper
	}

	func confirmWaterVolume(waterValue: Int) {
		registerDailyWaterConsumptionUseCase.registerDailyWaterConsumption(waterValue: waterValue)
			.subscribe(onCompleted: {
				if self.shouldRemind.value {
					self.scheduleNotificationOnConfirmEvent.accept(true)
				} else {
					self.completeProcess()
				}
			})
			.disposed(by: disposeBag)
	}

	func scheduleReminderNotifications() {
		let notificationSettings = NotificationSettings(
			isReminderEnabled: shouldRemind.value,
			notificationFrequency: .medium,
			startTime: timePeriodFifteenMinutesSpaced[initialTimeIndex.value],
			endTime: timePeriodFifteenMinutesSpaced[finalTimeIndex.value]
		)
		manageNotificationSettingsUseCase.setNotificationSetting(notificationSettings: notificationSettings)
		self.completeProcess()
	}

	func completeProcess() {
		self.stepper.steps.accept(FirstAccessFlowSteps.firstAccessUserInformationAlreadyProvided)
	}
}
