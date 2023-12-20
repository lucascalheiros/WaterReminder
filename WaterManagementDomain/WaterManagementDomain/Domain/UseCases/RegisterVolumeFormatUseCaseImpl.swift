//
//  RegisterVolumeFormatUseCase.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 06/08/23.
//

import Foundation

internal class RegisterVolumeFormatUseCaseImpl: RegisterVolumeFormatUseCase {
	let volumeFormatRepositoryProtocol: VolumeFormatRepository

	init(volumeFormatRepositoryProtocol: VolumeFormatRepository) {
		self.volumeFormatRepositoryProtocol = volumeFormatRepositoryProtocol
	}

	func setVolumeFormat(_ format: VolumeFormat) {
		volumeFormatRepositoryProtocol.setVolumeFormat(format)
	}
}
