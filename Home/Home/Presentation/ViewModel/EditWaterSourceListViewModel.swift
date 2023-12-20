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

class EditWaterSourceListViewModel: WaterSourceDeleteDelegate {
    
    let disposeBag = DisposeBag()
    let getWaterSourceUseCase: GetWaterSourceUseCase
    let manageWaterSourceUseCase: ManageWaterSourceUseCase
    let reorderWaterSourceUseCase: ReorderWaterSourceUseCase
    let homeFlowStepper: HomeFlowStepper

    @Published var waterSourceList: [WaterSource] = []
    @Published var volumeFormat: VolumeFormat = VolumeFormat.metric
    @Published var exhibitionList: [WaterSourceSectionItems] = []
    let removeItemNotifier = PassthroughSubject<Int, Never>()
    let updateListNotifier = PassthroughSubject<Void, Never>()

    init(
        getWaterSourceUseCase: GetWaterSourceUseCase,
        reorderWaterSourceUseCase: ReorderWaterSourceUseCase,
        manageWaterSourceUseCase: ManageWaterSourceUseCase,
        homeFlowStepper: HomeFlowStepper
    ) {
        self.getWaterSourceUseCase = getWaterSourceUseCase
        self.reorderWaterSourceUseCase = reorderWaterSourceUseCase
        self.manageWaterSourceUseCase = manageWaterSourceUseCase
        self.homeFlowStepper = homeFlowStepper
        getWaterSourceUseCase.getWaterSourceListWithVolumeFormat().subscribe(onNext: {
            let newList: [WaterSourceSectionItems] = $0.waterSourceList.map({ .waterSourceItem($0) }) + [.add]
            // Only update new itens inclusion, since other updates will be handled manually
            let isNewListBigger = newList.count > self.exhibitionList.count
            self.volumeFormat = $0.volumeFormat
            self.exhibitionList = newList
            if isNewListBigger {
                self.updateListNotifier.send(Void())
            }
        }).disposed(by: disposeBag)
    }

    func removeWaterSourceItem(_ waterSource: WaterSource) {
        guard let index = self.exhibitionList.firstIndex(where: {
            switch $0 {
            case .waterSourceItem(let item):
                return item.id == waterSource.id

            default:
                return false
            }
        }) else {
            return
        }
        self.exhibitionList.remove(at: index)
        self.removeItemNotifier.send(index)
    }


    func swapWaterSourcePositions(_ srcId: String, _ dstId: String) {
        self.reorderWaterSourceUseCase
            .reorderWaterSources(sourceId: srcId, destinationId: dstId)
            .subscribe()
            .disposed(by: disposeBag)
    }

    func showCreateWaterSource() {
        homeFlowStepper.showCreateWaterSource()
    }

    func onDeleteWaterSource(_ waterSource: WaterSource) {
        manageWaterSourceUseCase.deleteWaterSource(waterSource: waterSource)
            .do(onError: { error in
                print(error)
            })
            .subscribe(onCompleted: { [weak self] in
                self?.removeWaterSourceItem(waterSource)
            })
            .disposed(by: disposeBag)
    }

    enum WaterSourceSectionItems {
        case waterSourceItem(WaterSource)
        case add
    }
}
