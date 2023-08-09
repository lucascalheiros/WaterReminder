//
//  LocalePreferencesRepositoryProtocol.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 30/07/23.
//

import RxSwift

protocol LocalePreferencesRepositoryProtocol {
	func setWeightFormat(_ format: WeightFormat)
	func setTemperatureFormat(_ format: TemperatureFormat)
	func weightFormat() -> Observable<WeightFormat>
	func temperatureFormat() -> Observable<TemperatureFormat>
}
