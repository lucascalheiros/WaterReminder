//
//  GetLocalePreferencesUseCase.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 30/07/23.
//

import RxSwift

class GetLocalePreferencesUseCase {
	private let localePreferencesRepository: LocalePreferencesRepositoryProtocol

	init(localePreferencesRepository: LocalePreferencesRepositoryProtocol) {
		self.localePreferencesRepository = localePreferencesRepository
	}

	func weightFormat() -> Observable<WeightFormat> {
		localePreferencesRepository.weightFormat()
	}

	func temperatureFormat() -> Observable<TemperatureFormat> {
		localePreferencesRepository.temperatureFormat()
	}
}
