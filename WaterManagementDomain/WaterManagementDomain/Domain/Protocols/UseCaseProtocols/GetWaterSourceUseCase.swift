//
//  GetWaterSourceUseCase.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 06/08/23.
//

import RxSwift

public protocol GetWaterSourceUseCase {
	func getWaterSourceList() -> Observable<[WaterSource]>
    func getWaterSourceListWithVolumeFormat() -> Observable<WaterSourceListWithVolumeFormat> 
}

public struct WaterSourceListWithVolumeFormat {
    public let waterSourceList: [WaterSource]
    public let volumeFormat: VolumeFormat
}
