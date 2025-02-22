//
//  Drink.swift
//  WaterManagementDomain
//
//  Created by Lucas Calheiros on 08/02/25.
//

import UIKit
import Common

public struct Drink: Hashable, Codable {
    public var id: Int64?
    public var name: String
    public var hydrationFactor: Double = 1
    public var order: Int = .max
    public var lightColor: Int = 0x0000f4
    public var darkColor: Int = 0x26C6DA
    public var isDeleted: Bool = false

    public init(
        id: Int64? = nil,
        name: String
    ) {
        self.id = id
        self.name = name
    }

    public init(
        name: String,
        hydrationFactor: Double,
        lightColor: Int,
        darkColor: Int
    ){
        self.name = name
        self.hydrationFactor = hydrationFactor
        self.lightColor = lightColor
        self.darkColor = darkColor
    }
}


public extension Drink {
    var color: UIColor {
        UIColor { (traits) -> UIColor in
            traits.userInterfaceStyle == .dark ? darkColor.toColor : lightColor.toColor
        }
    }
}

