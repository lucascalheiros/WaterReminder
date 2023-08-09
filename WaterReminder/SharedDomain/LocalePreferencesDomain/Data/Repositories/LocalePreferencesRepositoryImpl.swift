//
//  LocalePreferencesRepositoryImpl.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 30/07/23.
//

import RxSwift

class LocalePreferencesRepositoryImpl: LocalePreferencesRepositoryProtocol {
	private lazy var defaults = UserDefaults.standard

	private var weightFormatObs: NSKeyValueObservation?
	private var temperatureFormatObs: NSKeyValueObservation?

	private lazy var mWeightFormat = {
		let value = self.defaults.integer(forKey: LocalePreferencesUserDefault.weightFormat.rawValue)
		return BehaviorSubject(value: WeightFormat(rawValue: value) ?? .metric)
	}()

	private lazy var mTemperatureFormat = {
		let value = self.defaults.integer(forKey: LocalePreferencesUserDefault.temperatureFormat.rawValue)
		return BehaviorSubject(value: TemperatureFormat(rawValue: value) ?? .celsius)
	}()

	func setWeightFormat(_ format: WeightFormat) {
		defaults.set(
			format.rawValue,
			forKey: LocalePreferencesUserDefault.weightFormat.rawValue
		)
	}

	func setTemperatureFormat(_ format: TemperatureFormat) {
		defaults.set(
			format.rawValue,
			forKey: LocalePreferencesUserDefault.temperatureFormat.rawValue
		)
	}

	func weightFormat() -> Observable<WeightFormat> {
		if weightFormatObs == nil {
			weightFormatObs = self.defaults.observe(\.weightFormat, options: [.new]) { [self] (_, change) in
				guard let newValue = change.newValue else { return }
				mWeightFormat.onNext(WeightFormat(rawValue: newValue) ?? .metric)
			}
		}
		return mWeightFormat
	}

	func temperatureFormat() -> Observable<TemperatureFormat> {
		if temperatureFormatObs == nil {
			temperatureFormatObs = self.defaults.observe(\.temperatureFormat, options: [.new]) { [self] (_, change) in
				guard let newValue = change.newValue else { return }
				mTemperatureFormat.onNext(TemperatureFormat(rawValue: newValue) ?? .celsius)
			}
		}
		return mTemperatureFormat
	}
}

enum LocalePreferencesUserDefault: String {
	case weightFormat
	case temperatureFormat
}

extension UserDefaults {
	@objc dynamic var weightFormat: Int {
		return integer(forKey: LocalePreferencesUserDefault.weightFormat.rawValue)
	}

	@objc dynamic var temperatureFormat: Int {
		return integer(forKey: LocalePreferencesUserDefault.temperatureFormat.rawValue)
	}
}
