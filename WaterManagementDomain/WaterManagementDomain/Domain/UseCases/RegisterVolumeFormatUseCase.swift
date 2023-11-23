//
//  RegisterVolumeFormatUseCase.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 06/08/23.
//

import Foundation

internal class RegisterVolumeFormatUseCase: RegisterVolumeFormatUseCaseProtocol {
	let volumeFormatRepositoryProtocol: VolumeFormatRepositoryProtocol

	init(volumeFormatRepositoryProtocol: VolumeFormatRepositoryProtocol) {
		self.volumeFormatRepositoryProtocol = volumeFormatRepositoryProtocol
	}

	func setVolumeFormat(_ format: VolumeFormat) {
		volumeFormatRepositoryProtocol.setVolumeFormat(format)
	}
}
