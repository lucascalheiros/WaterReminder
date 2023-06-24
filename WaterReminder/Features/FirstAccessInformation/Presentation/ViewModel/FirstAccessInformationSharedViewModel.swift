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

	let pageNavigationDelegate = FirstAccessInformationPageNavigationDelegate()

	let stepper: FirstAccessInformationStepper

	lazy var weight = BehaviorRelay(value: 70000)
	lazy var exerciseDays = BehaviorRelay(value: 3)
	lazy var temperatureLevel = BehaviorRelay(value: 20 ... 25)

	lazy var userInformation = {
		Observable.combineLatest(
			weight.asObservable(),
			exerciseDays.asObservable(),
			temperatureLevel.asObservable()
		) { weight, exerciseDays, temperatureLevel in
			UserInformation(id: nil, weightInGrams: weight, activityLevelInWeekDays: exerciseDays, ambienceTemperatureLevel: temperatureLevel, date: Date() )
		}
	}()

	lazy var expectedWaterVolume = {
		userInformation.map {
			self.expectedWaterConsumptionUseCase.calculateExpectedWaterConsumptionFromUserInformation($0)
		}
	}()

	internal init(expectedWaterConsumptionUseCase: GetExpectedWaterConsumptionUseCase, registerDailyWaterConsumptionUseCase: RegisterDailyWaterConsumptionUseCase, stepper: FirstAccessInformationStepper) {
		self.expectedWaterConsumptionUseCase = expectedWaterConsumptionUseCase
		self.registerDailyWaterConsumptionUseCase = registerDailyWaterConsumptionUseCase
		self.stepper = stepper
	}

	func setWeight(weightInGrams: Int) {
		weight.accept(weightInGrams)
	}

	func setExerciseDays(exerciseDays: Int) {
		self.exerciseDays.accept(exerciseDays)
	}

	func setTemperatureLevel(temperateLevelRange: ClosedRange<Int>) {
		self.temperatureLevel.accept(temperateLevelRange)
	}

	func registerWaterVolume(waterValue: Int) -> Completable {
		registerDailyWaterConsumptionUseCase.registerDailyWaterConsumption(waterValue: waterValue)
	}

	func completeProcess() {
		self.stepper.steps.accept(FirstAccessFlowSteps.firstAccessUserInformationAlreadyProvided)
	}
}
