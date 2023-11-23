//
//  GetVolumeFormatUseCaseProtocol.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 06/08/23.
//

import RxSwift

public protocol GetVolumeFormatUseCaseProtocol {
	func volumeFormat() -> Observable<VolumeFormat>
}

