//
//  EditWaterSourceListViewModel.swift
//  Home
//
//  Created by Lucas Calheiros on 19/12/23.
//

import Foundation
import WaterManagementDomain
import RxSwift
import Combine

class EditWaterSourceListViewModel {
    
    private var cancellableBag = Set<AnyCancellable>()
    private let deleteWaterSourceUseCase: DeleteWaterSourceUseCase
    private let reorderWaterSourceUseCase: ReorderWaterSourceUseCase
    private let homeFlowStepper: HomeFlowStepper
    private let getSortedWaterSourceUseCase: GetSortedWaterSourceUseCase
    private let getVolumeFormatUseCase: GetVolumeFormatUseCase

    @Published var waterSourceList: [WaterSource] = []
    lazy var volumeFormat = {
        getVolumeFormatUseCase.execute()
    }()
    @Published var exhibitionList: [WaterSourceSectionItems] = []
    let removeItemNotifier = PassthroughSubject<Int, Never>()
    let updateListNotifier = PassthroughSubject<Void, Never>()

    init(
        reorderWaterSourceUseCase: ReorderWaterSourceUseCase,
        deleteWaterSourceUseCase: DeleteWaterSourceUseCase,
        homeFlowStepper: HomeFlowStepper,
        getSortedWaterSourceUseCase: GetSortedWaterSourceUseCase,
        getVolumeFormatUseCase: GetVolumeFormatUseCase
    ) {
        self.reorderWaterSourceUseCase = reorderWaterSourceUseCase
        self.deleteWaterSourceUseCase = deleteWaterSourceUseCase
        self.homeFlowStepper = homeFlowStepper
        self.getSortedWaterSourceUseCase = getSortedWaterSourceUseCase
        self.getVolumeFormatUseCase = getVolumeFormatUseCase
        self.collectWaterSourceUpdates()
    }

    private func collectWaterSourceUpdates() {
        getSortedWaterSourceUseCase.execute().sinkUI { waterSourceList in
            let newList: [WaterSourceSectionItems] = waterSourceList.map({ .waterSourceItem($0) }) + [.add]
            let isSizeDifferent = newList.count != self.exhibitionList.count
            self.exhibitionList = newList
            if isSizeDifferent {
                self.updateListNotifier.send(Void())
            }
        }.store(in: &cancellableBag)
    }

    func removeWaterSourceItem(_ waterSource: WaterSource) {
        guard let index = self.exhibitionList.firstIndex(where: {
            switch $0 {
            case .waterSourceItem(let item):
                return item.cup.id == waterSource.id

            default:
                return false
            }
        }) else {
            return
        }
        self.exhibitionList.remove(at: index)
        self.removeItemNotifier.send(index)
    }


    func swapWaterSourcePositions(_ srcId: Int64, _ dstId: Int64) {
        Task {
            try? await self.reorderWaterSourceUseCase.execute(sourceId: srcId, destinationId: dstId)
        }
    }

    func showCreateWaterSource() {
        homeFlowStepper.showCreateWaterSource()
    }

    func onDeleteWaterSource(_ waterSource: WaterSource) {
        Task {
            try? await deleteWaterSourceUseCase.execute(waterSource)
        }
    }

    enum WaterSourceSectionItems {
        case waterSourceItem(CupInfo)
        case add
    }
}
