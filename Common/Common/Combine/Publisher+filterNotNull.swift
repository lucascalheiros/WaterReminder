//
//  Publisher+filterNotNull.swift
//  Common
//
//  Created by Lucas Calheiros on 25/12/23.
//

import Combine

public extension Publisher where Self.Failure == Never  {
    func filterNotNull<T>() -> AnyPublisher<T, Never> where Self.Output == T? {
        return self.compactMap { $0 }.eraseToAnyPublisher()
    }
}
