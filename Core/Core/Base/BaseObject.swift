//
//  BaseObject.swift
//  Core
//
//  Created by Lucas Calheiros on 27/05/23.
//


open class _BaseObject: Object {
    @Persisted(primaryKey: true) open var _id: ObjectId

    open var id: String? {
        get {
            return _id.stringValue
        }
        set {
            if let newValue {
                try? _id = ObjectId(string: newValue)
            }
        }
    }
}

public typealias BaseObject = _BaseObject & ObjectToDomainProtocol
