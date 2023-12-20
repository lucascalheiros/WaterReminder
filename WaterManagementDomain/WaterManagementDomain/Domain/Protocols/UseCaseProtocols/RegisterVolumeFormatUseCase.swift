//
//  RegisterVolumeFormatUseCase.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 06/08/23.
//

import RxSwift

public protocol RegisterVolumeFormatUseCase {
	func setVolumeFormat(_ format: VolumeFormat)
}
