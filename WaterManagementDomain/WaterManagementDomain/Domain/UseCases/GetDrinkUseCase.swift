//
//  GetDrinkUseCase.swift
//  WaterManagementDomain
//
//  Created by Lucas Calheiros on 09/02/25.
//

import Combine

public class GetDrinkUseCase {

    private let drinkRepository: DrinkRepository

    init(drinkRepository: DrinkRepository) {
        self.drinkRepository = drinkRepository
    }

    public func execute() -> AnyPublisher<[Drink], any Error> {
        drinkRepository.getDrinkList()
    }
}
