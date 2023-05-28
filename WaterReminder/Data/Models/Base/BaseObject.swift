//
//  BaseObject.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 27/05/23.
//

import RealmSwift

class _BaseObject: Object {
    
    @Persisted(primaryKey: true) var _id: ObjectId

    var id: String? {
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

typealias BaseObject = _BaseObject & ObjectToDomainProtocol
