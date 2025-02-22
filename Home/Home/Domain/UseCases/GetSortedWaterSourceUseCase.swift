//
//  GetSortedWaterSourceUseCase.swift
//  Home
//
//  Created by Lucas Calheiros on 21/02/25.
//

import WaterManagementDomain
import Combine

class GetSortedWaterSourceUseCase {

    private let getWaterSourceUseCase: GetWaterSourceUseCase

    init(getWaterSourceUseCase: GetWaterSourceUseCase) {
        self.getWaterSourceUseCase = getWaterSourceUseCase
    }

    func execute() -> AnyPublisher<[CupInfo], any Error> {
        getWaterSourceUseCase.getWaterSourceList()
            .map { $0.sorted { $0.cup.order ?? .max < $1.cup.order ?? .max} }
            .eraseToAnyPublisher()
    }
}
