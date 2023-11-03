//
//  GetWaterSourceUseCaseProtocol.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 06/08/23.
//

import RxSwift

protocol GetWaterSourceUseCaseProtocol {
	func getWaterSourceList() -> Observable<[WaterSource]>
    func getWaterSourceListWithVolumeFormat() -> Observable<WaterSourceListWithVolumeFormat> 
}

struct WaterSourceListWithVolumeFormat {
    let waterSourceList: [WaterSource]
    let volumeFormat: VolumeFormat
}
