//
//  ObjectToDomainProtocol.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 27/05/23.
//

import Foundation

protocol ObjectToDomainProtocol {
    
    associatedtype DomainType

    func toDomainModel() -> DomainType
    
}
