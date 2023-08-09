//
//  VolumeFormatRepositoryProtocol.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 06/08/23.
//

import RxSwift

protocol VolumeFormatRepositoryProtocol {
	func setVolumeFormat(_ format: VolumeFormat)
	func volumeFormat() -> Observable<VolumeFormat>
}
