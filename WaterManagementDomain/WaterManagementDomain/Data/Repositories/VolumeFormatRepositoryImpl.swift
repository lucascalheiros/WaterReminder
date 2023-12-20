//
//  VolumeFormatRepositoryImpl.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 06/08/23.
//

import RxSwift

internal class VolumeFormatRepositoryImpl: VolumeFormatRepository {
	private lazy var defaults = UserDefaults.standard

	private var volumeFormatKVO: NSKeyValueObservation?

	private lazy var volumeFormatSubject = {
		let value = defaults.integer(forKey: VolumeFormatUserDefault.volumeFormat.rawValue)
		return BehaviorSubject(value: VolumeFormat(rawValue: value) ?? .metric)
	}()

	func setVolumeFormat(_ format: VolumeFormat) {
		defaults.set(
			format.rawValue,
			forKey: VolumeFormatUserDefault.volumeFormat.rawValue
		)
	}

	func volumeFormat() -> Observable<VolumeFormat> {
		if volumeFormatKVO == nil {
			volumeFormatKVO = defaults.observe(\.volumeFormat, options: [.new]) { [weak self] (_, change) in
				guard let newValue = change.newValue else { return }
				self?.volumeFormatSubject.onNext(VolumeFormat(rawValue: newValue) ?? .metric)
			}
		}
		return volumeFormatSubject
	}
}

enum VolumeFormatUserDefault: String {
	case volumeFormat
}

extension UserDefaults {
	@objc dynamic var volumeFormat: Int {
		return integer(forKey: VolumeFormatUserDefault.volumeFormat.rawValue)
	}
}
