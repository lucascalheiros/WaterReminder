//
//  DrinkRepository.swift
//  WaterManagementDomain
//
//  Created by Lucas Calheiros on 09/02/25.
//

import Combine

protocol DrinkRepository {
    func getDrinkList() -> AnyPublisher<[Drink], any Error>
    func createDrink(_ drink: Drink) async throws
    func deleteDrink(_ drink: Drink) async throws
}
