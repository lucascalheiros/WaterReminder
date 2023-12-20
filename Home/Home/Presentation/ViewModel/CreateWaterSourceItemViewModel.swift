//
//  CreateWaterSourceItemViewModel.swift
//  Home
//
//  Created by Lucas Calheiros on 18/12/23.
//

import Combine
import WaterManagementDomain
import RxSwift

class CreateWaterSourceItemViewModel {

    let disposeBag: DisposeBag = DisposeBag()
    let getVolumeFormatUseCase: GetVolumeFormatUseCase
    let manageWaterSourceUseCase: ManageWaterSourceUseCase

    @Published var waterSourceType = WaterSourceType.water
    @Published var waterInMl = 500
    @Published var volumeFormat: VolumeFormat = VolumeFormat.metric
    
    lazy var waterWithFormat = $waterInMl.combineLatest($volumeFormat).map {
        WaterWithFormat(waterInML: $0, volumeFormat: $1)
    }

    init(getVolumeFormatUseCase: GetVolumeFormatUseCase, manageWaterSourceUseCase: ManageWaterSourceUseCase) {
        self.getVolumeFormatUseCase = getVolumeFormatUseCase
        self.manageWaterSourceUseCase = manageWaterSourceUseCase

        getVolumeFormatUseCase.volumeFormat().subscribe(onNext: { self.volumeFormat = $0 }).disposed(by: disposeBag)
    }

    func getCurrentWaterWithFormat() -> WaterWithFormat {
        WaterWithFormat(waterInML: waterInMl, volumeFormat: volumeFormat)
    }

    func saveWaterSource() {
        manageWaterSourceUseCase.createWaterSource(waterVolume: waterInMl, waterSourceType: waterSourceType)
            .subscribe(onCompleted: {}).disposed(by: disposeBag)
    }

}
