//
//  HistoryViewModel.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 12/08/23.
//

import RxRelay
import RxSwift
import WaterManagementDomain
import Combine

class HistoryViewModel {
    let disposeBag = DisposeBag()
    let getWaterConsumedUseCase: GetWaterConsumedUseCase
    let getVolumeFormatUseCase: GetVolumeFormatUseCase
    let getDailyWaterConsumptionUseCase: GetDailyWaterConsumptionUseCase
    let getConsumedWaterPercentageUseCase: GetConsumedWaterPercentageUseCase
    let manageWaterConsumedUseCase: ManageWaterConsumedUseCase

    @Published var volumeFormat: VolumeFormat?
    @Published var expectedWaterVolume: Float = 0
    @Published var waterConsumedList: [WaterConsumed] = []
    lazy var waterConsumedByDay = $waterConsumedList.map {
        Dictionary(grouping: $0.reversed(), by: { $0.consumptionTime.startOfDay })
    }

    let historyChartModel = HistoryChartViewModel()

    init(
        getWaterConsumedUseCase: GetWaterConsumedUseCase,
        getVolumeFormatUseCase: GetVolumeFormatUseCase,
        getDailyWaterConsumptionUseCase: GetDailyWaterConsumptionUseCase,
        getConsumedWaterPercentageUseCase: GetConsumedWaterPercentageUseCase,
        manageWaterConsumedUseCase: ManageWaterConsumedUseCase
    ) {
        self.getWaterConsumedUseCase = getWaterConsumedUseCase
        self.getVolumeFormatUseCase = getVolumeFormatUseCase
        self.getDailyWaterConsumptionUseCase = getDailyWaterConsumptionUseCase
        self.getConsumedWaterPercentageUseCase = getConsumedWaterPercentageUseCase
        self.manageWaterConsumedUseCase = manageWaterConsumedUseCase
        observeData()
    }

    private func observeData() {
        getVolumeFormatUseCase.volumeFormat()
            .bind { [weak self] in
                self?.volumeFormat = $0
                self?.historyChartModel.volumeFormat = $0
            }.disposed(by: disposeBag)
        getDailyWaterConsumptionUseCase.lastDailyWaterConsumption().map { $0?.expectedVolume.toFloat() ?? 0}
            .bind { [weak self] in
                self?.expectedWaterVolume = $0
                self?.historyChartModel.expectedWaterVolume = $0
            }.disposed(by: disposeBag)
        getWaterConsumedUseCase.getWaterConsumedList(nil, nil)
            .bind { [weak self] in
                self?.waterConsumedList = $0
                self?.historyChartModel.waterConsumedList = $0
            }.disposed(by: disposeBag)
    }

    func waterPercentageWithTypeByDay(_ date: Date) -> AnyPublisher<[PercentageWithWaterSourceType], Never> {
        waterConsumedByDay.combineLatest($expectedWaterVolume).map {
            self.getConsumedWaterPercentageUseCase.waterPercentageWithTypeByConsumedList(expectedWaterVolume: $1, waterConsumedList: $0[date.startOfDay] ?? [])
        }.eraseToAnyPublisher()
    }   

    func waterConsumedByDay(_ date: Date) -> AnyPublisher<WaterWithFormat, Never> {
        $volumeFormat.combineLatest(waterConsumedByDay).compactMap {
            guard let waterConsumedList = $1[date.startOfDay], let volumeFormat = $0 else {
                return nil
            }
            let volume = waterConsumedList.map { $0.volume }.reduce(0, +)
            return WaterWithFormat(waterInML: volume, volumeFormat: volumeFormat)
        }.eraseToAnyPublisher()
    }

    func deleteWaterConsumed(_ waterConsumed: WaterConsumed) {
        manageWaterConsumedUseCase.deleteWaterConsumed(waterConsumed).subscribe().disposed(by: disposeBag)
    }

}
