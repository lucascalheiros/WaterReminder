//
//  GetVolumeFormatUseCaseImpl.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 06/08/23.
//

import Combine

public class GetVolumeFormatUseCase {
	let volumeFormatRepositoryProtocol: VolumeFormatRepository

	init(volumeFormatRepositoryProtocol: VolumeFormatRepository) {
		self.volumeFormatRepositoryProtocol = volumeFormatRepositoryProtocol
	}

    public func execute() -> AnyPublisher<SystemFormat, Never> {
		volumeFormatRepositoryProtocol.volumeFormat()
	}
}
