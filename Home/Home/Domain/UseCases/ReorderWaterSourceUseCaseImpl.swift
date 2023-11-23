//
//  ReorderWaterSourceUseCaseImpl.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 22/10/23.
//

import RxSwift
import WaterManagementDomain

class ReorderWaterSourceUseCaseImpl: ReorderWaterSourceUseCase {

	private let getWaterSourceUseCase: GetWaterSourceUseCaseProtocol
	private let manageWaterSourceUseCase: ManageWaterSourceUseCaseProtocol

	init(getWaterSourceUseCase: GetWaterSourceUseCaseProtocol, manageWaterSourceUseCase: ManageWaterSourceUseCaseProtocol) {
		self.getWaterSourceUseCase = getWaterSourceUseCase
		self.manageWaterSourceUseCase = manageWaterSourceUseCase
	}

	func reorderWaterSources(sourceId: String, destinationId: String) -> Completable {
		return getWaterSourceUseCase.getWaterSourceList().safeAsSingle().flatMapCompletable({
			var data = $0
			let sourceWaterSourceIndex = data.firstIndex(where: { $0.id == sourceId })!
			let destinationWaterSourceIndex = data.firstIndex(where: { $0.id == destinationId })!
			let mover = data.remove(at: sourceWaterSourceIndex)
			data.insert(mover, at: destinationWaterSourceIndex)
			let updatedData = data.enumerated().map({ index, item in
				item.copy(order: index)
			})
			return self.manageWaterSourceUseCase.updateWaterSources(waterSources: updatedData)
		})
	}

}
