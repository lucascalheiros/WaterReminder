//
//  DeleteDrinkUseCase.swift
//  WaterManagementDomain
//
//  Created by Lucas Calheiros on 22/02/25.
//

public class DeleteDrinkUseCase {

    private let drinkRepository: DrinkRepository

    init(drinkRepository: DrinkRepository) {
        self.drinkRepository = drinkRepository
    }

    public func execute(_ drink: Drink) async throws {
        try await drinkRepository.deleteDrink(drink)
    }

}
