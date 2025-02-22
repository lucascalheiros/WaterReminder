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
    private var cancellableBag: Set<AnyCancellable> = []
    let disposeBag = DisposeBag()
    let getWaterConsumedUseCase: GetWaterConsumedUseCase
    let getVolumeFormatUseCase: GetVolumeFormatUseCase
    let getDailyWaterConsumptionUseCase: GetDailyWaterConsumptionUseCase
    let getConsumptionSummaryUseCase: GetConsumptionSummaryUseCase
    let deleteWaterConsumedUseCase: DeleteWaterConsumedUseCase

    @Published var volumeFormat: SystemFormat?
    @Published var expectedWaterVolume: Float = 0
    @Published var waterConsumedList: [ConsumedCupInfo] = []
    lazy var waterConsumedByDay: AnyPublisher<[Date:[ConsumedCupInfo]], Never> = $waterConsumedList.map {
        Dictionary(grouping: $0.reversed(), by: { $0.consumedCup.consumptionTime.startOfDay })
    }.eraseToAnyPublisher()

    let historyChartModel = HistoryChartViewModel()

    init(
        getWaterConsumedUseCase: GetWaterConsumedUseCase,
        getVolumeFormatUseCase: GetVolumeFormatUseCase,
        getDailyWaterConsumptionUseCase: GetDailyWaterConsumptionUseCase,
        getConsumptionSummaryUseCase: GetConsumptionSummaryUseCase,
        deleteWaterConsumedUseCase: DeleteWaterConsumedUseCase
    ) {
        self.getWaterConsumedUseCase = getWaterConsumedUseCase
        self.getVolumeFormatUseCase = getVolumeFormatUseCase
        self.getDailyWaterConsumptionUseCase = getDailyWaterConsumptionUseCase
        self.getConsumptionSummaryUseCase = getConsumptionSummaryUseCase
        self.deleteWaterConsumedUseCase = deleteWaterConsumedUseCase
        observeData()
    }

    private func observeData() {
        getVolumeFormatUseCase.execute()
            .sinkUI { [weak self] in
                self?.volumeFormat = $0
                self?.historyChartModel.volumeFormat = $0
            }.store(in: &cancellableBag)
        getDailyWaterConsumptionUseCase.lastDailyWaterConsumption().map { $0?.expectedVolume.toFloat() ?? 0}
            .sinkUI { [weak self] in
                self?.expectedWaterVolume = $0
                self?.historyChartModel.expectedWaterVolume = $0
            }.store(in: &cancellableBag)
        getWaterConsumedUseCase.getWaterConsumedList(nil, nil)
            .sinkUI { [weak self] in
                self?.waterConsumedList = $0
                self?.historyChartModel.waterConsumedList = $0
            }.store(in: &cancellableBag)
    }

    func waterPercentageWithTypeByDay(_ date: Date) -> AnyPublisher<ConsumptionSummary, Never> {
        waterConsumedByDay.combineLatest($expectedWaterVolume).map {
            ConsumptionSummary(expectedVolume: Volume($1, .milliliters), consumedCups: $0[date.startOfDay] ?? [])
        }.eraseToAnyPublisher()
    }

    public func deleteWaterConsumed(_ waterConsumed: WaterConsumed) {
        Task {
            try await deleteWaterConsumedUseCase.execute(waterConsumed)
        }
    }

}
