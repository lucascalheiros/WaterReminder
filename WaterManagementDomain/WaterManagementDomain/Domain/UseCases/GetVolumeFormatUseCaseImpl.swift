//
//  GetVolumeFormatUseCaseImpl.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 06/08/23.
//

import RxSwift

internal class GetVolumeFormatUseCaseImpl: GetVolumeFormatUseCase {
	let volumeFormatRepositoryProtocol: VolumeFormatRepository

	init(volumeFormatRepositoryProtocol: VolumeFormatRepository) {
		self.volumeFormatRepositoryProtocol = volumeFormatRepositoryProtocol
	}

	func volumeFormat() -> Observable<VolumeFormat> {
		volumeFormatRepositoryProtocol.volumeFormat()
	}
}
