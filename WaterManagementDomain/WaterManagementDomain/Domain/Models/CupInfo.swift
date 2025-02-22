//
//  CupInfo.swift
//  WaterManagementDomain
//
//  Created by Lucas Calheiros on 21/02/25.
//

import GRDB

public struct CupInfo: Decodable, Hashable {
    public var cup: WaterSource
    public var drink: Drink
}
