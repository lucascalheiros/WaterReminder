//
//  ExpectedWaterConsumptionUseCase.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 04/06/23.
//

import Foundation
import Combine

public class GetExpectedWaterConsumptionUseCase {
	private let userInformationRepository: UserInformationRepository
	private let multiplierConstantFactor = 0.030
	private let activityLevelMultiplierFactor = 0.020 / 7

	internal init(userInformationRepository: UserInformationRepository) {
		self.userInformationRepository = userInformationRepository
	}

    public func getExpectedWaterConsumptionByCurrentUserInformation() -> AnyPublisher<ExpectedWaterConsumptionState, any Error> {
		userInformationRepository.getUserInformationList().map {
			if let userInformation = $0.max(by: { $0.date < $1.date }) {
				return self.calculateExpectedWaterConsumptionFromUserInformation(userInformation)
			} else {
				return .unableToInfer
			}
        }.eraseToAnyPublisher()
	}

	public func calculateExpectedWaterConsumptionFromUserInformation(
		_ userInformation: UserInformation
	) -> ExpectedWaterConsumptionState {
		guard let weightInGrams = userInformation.weightInGrams?.toDouble() else {
			return .unableToInfer
		}
        guard let activityLevel = userInformation.activityLevel?.waterFactor else {
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

extension ActivityLevel {
    var waterFactor: Double {
        switch self {

        case .none:
            0
        case .light:
            2
        case .moderate:
            4
        case .heavy:
            7
        }
    }
}

public enum ExpectedWaterConsumptionState {
	case successful(waterQuantity: Int)
	case unableToInfer
}
