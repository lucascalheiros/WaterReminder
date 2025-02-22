//
//  RegisterVolumeFormatUseCase.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 06/08/23.
//

import Foundation

public class RegisterVolumeFormatUseCase {
	let volumeFormatRepositoryProtocol: VolumeFormatRepository

	init(volumeFormatRepositoryProtocol: VolumeFormatRepository) {
		self.volumeFormatRepositoryProtocol = volumeFormatRepositoryProtocol
	}

	public func setVolumeFormat(_ format: SystemFormat) {
		volumeFormatRepositoryProtocol.setVolumeFormat(format)
	}
}
