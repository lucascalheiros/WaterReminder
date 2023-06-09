//
//  RxSwiftExt.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 27/05/23.
//

import RxSwift

extension Observable {
    func safeAsSingle() -> Single<Element> {
        self.take(1).asSingle()
    }

	func subscribe(function: ((Element) -> Void)?) -> Disposable {
		self.subscribe(onNext: function)
	}
}
