//
//  AddDrinkViewModel.swift
//  Home
//
//  Created by Lucas Calheiros on 09/02/25.
//

import Combine
import UIKit
import WaterManagementDomain

class AddDrinkViewModel {

    @Published private(set) var name: String = ""
    @Published private(set) var hydration: Double = 1.0
    @Published private(set) var lightColor: UIColor = 0x0000f4.toColor
    @Published private(set) var darkColor: UIColor = 0x26C6DA.toColor
    
    private let createDrinkUseCase: CreateDrinkUseCase

    init(createDrinkUseCase: CreateDrinkUseCase) {
        self.createDrinkUseCase = createDrinkUseCase
    }

    func setName(_ name: String) {
        self.name = name
    }

    func setHydration(_ hydration: Double) {
        self.hydration = hydration
    }

    func setLightColor(_ color: UIColor) {
        self.lightColor = color
    }

    func setDarkColor(_ color: UIColor) {
        self.darkColor = color
    }

    func save() {
        Task {
            try await createDrinkUseCase.execute(Drink(
                name: name,
                hydrationFactor: hydration,
                lightColor: lightColor.intValue,
                darkColor: darkColor.intValue
            ))
        }
    }

}

struct ThemedColor {
    var lightColor: Int
    var darkColor: Int
}
