//
//  ReorderWaterSourceUseCase.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 22/10/23.
//

import RxSwift
import WaterManagementDomain

class ReorderWaterSourceUseCase {

    private let getSortedWaterSourceUseCase: GetSortedWaterSourceUseCase
    private let updateWaterSourceUseCase: UpdateWaterSourceUseCase

	init(
        getSortedWaterSourceUseCase: GetSortedWaterSourceUseCase,
        updateWaterSourceUseCase: UpdateWaterSourceUseCase
    ) {
		self.getSortedWaterSourceUseCase = getSortedWaterSourceUseCase
		self.updateWaterSourceUseCase = updateWaterSourceUseCase
	}

    func execute(sourceId: Int64, destinationId: Int64) async throws {
        var data = try await getSortedWaterSourceUseCase.execute().awaitFirst()
        guard let sourceWaterSourceIndex = data.firstIndex(where: { $0.cup.id == sourceId }),
              let destinationWaterSourceIndex = data.firstIndex(where: { $0.cup.id == destinationId }) else {
            return
        }
        let mover = data.remove(at: sourceWaterSourceIndex)
        data.insert(mover, at: destinationWaterSourceIndex)
        let updatedData = data.enumerated().map({ index, item in
            var newItem = item.cup
            newItem.order = index
            return newItem
        })
        try await self.updateWaterSourceUseCase.execute(updatedData)
	}

}
