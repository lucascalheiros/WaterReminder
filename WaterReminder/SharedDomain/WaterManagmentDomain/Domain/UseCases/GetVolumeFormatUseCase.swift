//
//  GetVolumeFormatUseCase.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 06/08/23.
//

import RxSwift

internal class GetVolumeFormatUseCase: GetVolumeFormatUseCaseProtocol {
	let volumeFormatRepositoryProtocol: VolumeFormatRepositoryProtocol

	init(volumeFormatRepositoryProtocol: VolumeFormatRepositoryProtocol) {
		self.volumeFormatRepositoryProtocol = volumeFormatRepositoryProtocol
	}

	func volumeFormat() -> Observable<VolumeFormat> {
		volumeFormatRepositoryProtocol.volumeFormat()
	}
}
