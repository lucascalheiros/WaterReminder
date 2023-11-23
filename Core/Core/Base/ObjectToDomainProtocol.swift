//
//  ObjectToDomainProtocol.swift
//  Core
//
//  Created by Lucas Calheiros on 13/11/23.
//

import Foundation

public protocol ObjectToDomainProtocol {

    associatedtype DomainType

    func toDomainModel() -> DomainType

}
