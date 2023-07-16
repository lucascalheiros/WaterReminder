//
//  ExpectedWaterConsumptionUseCase.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 04/06/23.
//

import Foundation
import RxSwift

class GetExpectedWaterConsumptionUseCase {
	private let userInformationRepository: UserInformationRepositoryProtocol
	private let multiplierConstantFactor = 0.030
	private let activityLevelMultiplierFactor = 0.020 / 7

	internal init(userInformationRepository: UserInformationRepositoryProtocol) {
		self.userInformationRepository = userInformationRepository
	}

	func getExpectedWaterConsumptionByCurrentUserInformation() -> Observable<ExpectedWaterConsumptionState> {
		userInformationRepository.getUserInformationList().map {
			if let userInformation = $0.max(by: { $0.date < $1.date }) {
				return self.calculateExpectedWaterConsumptionFromUserInformation(userInformation)
			} else {
				return .unableToInfer
			}
		}
	}

	func calculateExpectedWaterConsumptionFromUserInformation(
		_ userInformation: UserInformation
	) -> ExpectedWaterConsumptionState {
		guard let weightInGrams = userInformation.weightInGrams?.toDouble() else {
			return .unableToInfer
		}
		guard let activityLevel = userInformation.activityLevelInWeekDays?.toDouble() else {
			return .unableToInfer
		}
		guard let intakeFromAmbienceLevel = (userInformation.ambienceTemperatureLevel.run {
			intakeFromAmbienceLevel(ambienceTemperatureLevel: $0)
		}?.toDouble()) else {
			return .unableToInfer
		}
		let activityBasedMultiplier = activityLevel * activityLevelMultiplierFactor + multiplierConstantFactor
		let waterIntake = weightInGrams * activityBasedMultiplier + intakeFromAmbienceLevel
		return .successful(waterQuantity: waterIntake.toInt())
	}

	private func intakeFromAmbienceLevel(ambienceTemperatureLevel: AmbienceTemperatureLevel) -> Int {
		switch ambienceTemperatureLevel {
		case .moderate:
			return 100
		case .warn:
			return 250
		case .hot:
			return 500
		default:
			return 0
		}
	}
}

enum ExpectedWaterConsumptionState {
	case successful(waterQuantity: Int)
	case unableToInfer
}
