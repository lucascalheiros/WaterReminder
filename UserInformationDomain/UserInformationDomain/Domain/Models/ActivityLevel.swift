//
//  ActivityLevel.swift
//  UserInformationDomain
//
//  Created by Lucas Calheiros on 05/02/25.
//

public enum ActivityLevel: String, CaseIterable, Identifiable, Codable {
    case none
    case light
    case moderate
    case heavy

    public var id: ActivityLevel {
        self
    }
}
