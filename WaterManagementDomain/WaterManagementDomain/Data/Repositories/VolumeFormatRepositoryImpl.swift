//
//  VolumeFormatRepositoryImpl.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 06/08/23.
//

import Combine
import Foundation

internal class VolumeFormatRepositoryImpl: VolumeFormatRepository {
    private lazy var defaults = UserDefaults.standard

    private var volumeFormatKVO: NSKeyValueObservation?

    @Published private var volumeFormatSubject: SystemFormat!

    init() {
        volumeFormatSubject = currentFormat()
    }

    func setVolumeFormat(_ format: SystemFormat) {
        defaults.set(
            format.rawValue,
            forKey: VolumeFormatUserDefault.volumeFormat.rawValue
        )
    }

    func currentFormat() -> SystemFormat{
        let value = self.defaults.integer(forKey: VolumeFormatUserDefault.volumeFormat.rawValue)
        return SystemFormat(rawValue: value) ?? .metric
    }

    func volumeFormat() -> AnyPublisher<SystemFormat, Never> {
        if volumeFormatKVO == nil {
            volumeFormatKVO = defaults.observe(\.volumeFormat, options: [.new]) { [weak self] (_, change) in
                guard let newValue = change.newValue else { return }
                self?.volumeFormatSubject = SystemFormat(rawValue: newValue) ?? .metric
            }
        }
        return $volumeFormatSubject.compactMap{$0}.eraseToAnyPublisher()
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
