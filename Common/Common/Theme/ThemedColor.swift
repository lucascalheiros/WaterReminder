//
//  ThemedColor.swift
//  Components
//
//  Created by Lucas Calheiros on 17/11/23.
//

import UIKit

public struct ThemedColor: ThemedColorProtocol {
    public let color: UIColor
    public let onColor: UIColor

    public init(color: UIColor, onColor: UIColor) {
        self.color = color
        self.onColor = onColor
    }
}
