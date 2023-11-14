//
//  BaseRepository.swift
//  Core
//
//  Created by Lucas Calheiros on 27/05/23.
//

import Foundation
import RealmSwift
import RxRealm
import RxSwift

open class BaseRepository<T: BaseObject> {
	private let provider: RealmProviderProtocol

    public init(_ provider: RealmProviderProtocol) {
		self.provider = provider
	}
    
    open var realm: Realm {
        get throws {
            try self.provider.getInstance()
        }
    }
    
    open func save(_ data: T) -> Completable {
        save([data])
    }
    
    open func save(_ data: [T]) -> Completable {
        return Completable.create { completable in
            do {
                let realm = try self.realm
                try realm.write {
                    realm.add(data, update: .modified)
                }
                completable(.completed)
            } catch let error {
                print(error)
                completable(.error(error))
            }
            return Disposables.create()
        }
    }
    
    open func list() -> Observable<[T.DomainType]> {
        do {
            let object = try realm.objects(T.self)
            return Observable.collection(from: object)
                .map { $0.map { $0.toDomainModel() } }
        } catch let error {
            print(error)
            return Observable.error(error)
        }
    }

    open func delete(_ id: ObjectId) -> Completable {
        return Completable.create { completable in
            do {
                let realm = try self.realm
                try realm.write {
                    let objects = realm.objects(T.self).where {
                        $0._id == id
                    }
                    realm.delete(objects)
                }
                completable(.completed)
            } catch let error {
                print(error)
                completable(.error(error))
            }
            return Disposables.create()
        }
    }
}
