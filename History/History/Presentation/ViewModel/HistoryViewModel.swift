//
//  HistoryViewModel.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 12/08/23.
//

import RxRelay
import RxSwift
import WaterManagementDomain

class HistoryViewModel {
    let disposeBag = DisposeBag()
    let getWaterConsumedUseCase: GetWaterConsumedUseCase
    let getVolumeFormatUseCase: GetVolumeFormatUseCase
    let getDailyWaterConsumptionUseCase: GetDailyWaterConsumptionUseCase
    let getConsumedWaterPercentageUseCase: GetConsumedWaterPercentageUseCase
    let manageWaterConsumedUseCase: ManageWaterConsumedUseCase

    lazy var todayWaterConsumedList = {
        let currentDate = Date()
        let startOfDay = currentDate.startOfDay
        let endOfDay = currentDate.endOfDay
        return getWaterConsumedUseCase.getWaterConsumedList(startOfDay, endOfDay)
    }()

    lazy var volumeFormat = BehaviorRelay<VolumeFormat?>(value: nil)

    lazy var todayConsumedVolume = BehaviorRelay<WaterWithFormat?>(value: nil)

    lazy var todayConsumedWaterPercentage: Observable<[PercentageWithWaterSourceType]> = {
        getConsumedWaterPercentageUseCase.dailyConsumedWaterPercentageWithWaterType(date: Date())
    }()

    var daysBeingShown = BehaviorRelay(value: 7)

    var waterConsumedByDay = BehaviorRelay<[Date:[WaterConsumed]]>(value: [:])

    lazy var expectedWaterVolumeRelay = {
        let expectedWaterVolumeRelay = BehaviorRelay<Float>(value: 0)
        getDailyWaterConsumptionUseCase.lastDailyWaterConsumption().map { $0?.expectedVolume.toFloat() ?? 0}.bind(to: expectedWaterVolumeRelay).disposed(by: disposeBag)
        return expectedWaterVolumeRelay
    }()

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
        getVolumeFormatUseCase.volumeFormat()
            .bind(to: volumeFormat).disposed(by: disposeBag)
        getWaterConsumedUseCase.getWaterConsumedVolumeToday()
            .bind(to: todayConsumedVolume).disposed(by: disposeBag)

        loadDaysOfHistory(numberOfDays: 7)
    }

    func loadDaysOfHistory(numberOfDays: Int) {
        let currentDate = Date()
        let endOfPeriod = currentDate.endOfDay
        var dateComponent = DateComponents()
        dateComponent.day = -numberOfDays
        let startOfPeriod = Calendar.current.date(byAdding: dateComponent, to: currentDate)!.startOfDay
        getWaterConsumedUseCase.getWaterConsumedList(startOfPeriod, endOfPeriod).map {
            Dictionary(grouping: $0.reversed(), by: { $0.consumptionTime.startOfDay })
        }.bind(to: waterConsumedByDay).disposed(by: disposeBag)
    }

    func waterPercentageWithTypeByDay(_ date: Date) -> Observable<[PercentageWithWaterSourceType]> {
        Observable.combineLatest(waterConsumedByDay, expectedWaterVolumeRelay).map {
            self.getConsumedWaterPercentageUseCase.waterPercentageWithTypeByConsumedList(expectedWaterVolume: $1, waterConsumedList: $0[date.startOfDay] ?? [])
        }
    }   

    func waterConsumedByDay(_ date: Date) -> Observable<WaterWithFormat> {
        Observable.combineLatest(volumeFormat.filterNotNull(), waterConsumedByDay).compactMap {
            guard let waterConsumedList = $1[date.startOfDay] else {
                return nil
            }
            let volume = waterConsumedList.map { $0.volume }.reduce(0, +)
            return WaterWithFormat(waterInML: volume, volumeFormat: $0)
        }
    }

    func deleteWaterConsumed(_ waterConsumed: WaterConsumed) {
        manageWaterConsumedUseCase.deleteWaterConsumed(waterConsumed).subscribe().disposed(by: disposeBag)
    }

}
