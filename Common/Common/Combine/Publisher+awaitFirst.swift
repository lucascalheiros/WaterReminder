//
//  Publisher+awaitFirst.swift
//  Common
//
//  Created by Lucas Calheiros on 06/12/23.
//

import Combine

public extension Publisher where Self.Failure == Never {
    func awaitFirst<T>() async throws -> T where Self.Output == T {
        for try await value in self.values {
            return value
        }
        throw fatalError("Value never came")
    }
}


public extension Publisher where Self.Failure == any Error {
    func awaitFirst<T>() async throws -> T where Self.Output == T {
        for try await value in self.values {
            return value
        }
        throw fatalError("Value never came")
    }
}


public extension Publisher where Self.Failure == any Error {
    func catchNever() -> AnyPublisher<Self.Output, Never> {
        self.catch {_ in Empty<Self.Output, Never>()}.eraseToAnyPublisher()
    }
}

