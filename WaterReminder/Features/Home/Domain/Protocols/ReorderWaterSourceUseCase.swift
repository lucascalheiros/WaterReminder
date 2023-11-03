//
//  ReorderWaterSourceUseCase.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 22/10/23.
//

import RxSwift

protocol ReorderWaterSourceUseCase {
	func reorderWaterSources(sourceId: String, destinationId: String) -> Completable
}
