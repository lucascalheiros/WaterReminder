//
//  Publisher+sinkUI.swift
//  Common
//
//  Created by Lucas Calheiros on 21/02/25.
//


import Combine
import UIKit

public extension Publisher where Self.Failure == Never {
    func sinkUI(receiveValue: @escaping ((Self.Output) -> Void)) -> AnyCancellable {
        receive(on: DispatchQueue.main)
            .sink(receiveValue: receiveValue)
    }
}


public extension Publisher where Self.Failure == any Error {
    func sinkUI(receiveValue: @escaping ((Self.Output) -> Void)) -> AnyCancellable {
        catchNever()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: receiveValue)
    }
}

