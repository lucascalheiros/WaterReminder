//
//  VolumeFormatRepository.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 06/08/23.
//

import Combine

protocol VolumeFormatRepository {
	func setVolumeFormat(_ format: SystemFormat)
	func volumeFormat() -> AnyPublisher<SystemFormat, Never>
}
