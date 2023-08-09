//
//  ManageLocalePreferencesUseCase.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 30/07/23.
//

import Foundation

class ManageLocalePreferencesUseCase {
	private let localePreferencesRepository: LocalePreferencesRepositoryProtocol

	init(localePreferencesRepository: LocalePreferencesRepositoryProtocol) {
		self.localePreferencesRepository = localePreferencesRepository
	}

	func setWeightFormat(_ format: WeightFormat) {
		localePreferencesRepository.setWeightFormat(format)
	}

	func setTemperatureFormat(_ format: TemperatureFormat) {
		localePreferencesRepository.setTemperatureFormat(format)
	}
}
