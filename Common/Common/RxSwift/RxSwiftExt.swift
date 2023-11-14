//
//  RxSwiftExt.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 27/05/23.
//

import RxSwift

public extension Observable {
    func safeAsSingle() -> Single<Element> {
        self.take(1).asSingle()
    }
}

public extension ObservableType {
    func filterNotNull<T>() -> Observable<T> where Element == T? {
        return self.compactMap { $0 }
    }
}

