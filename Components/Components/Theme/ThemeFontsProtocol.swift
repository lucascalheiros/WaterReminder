//
//  ThemeFontsProtocol.swift
//  Components
//
//  Created by Lucas Calheiros on 18/11/23.
//

import UIKit

public protocol ThemeFontsProtocol {
    var h1: UIFont { get }
    var h2: UIFont { get }
    var h3: UIFont { get }
    var h4: UIFont { get }
    var body: UIFont { get }
    var caption: UIFont { get }
    var screenTitle: UIFont { get }
    var sectionTitle: UIFont { get }
    var buttonBig: UIFont { get }
    var buttonDefault: UIFont { get }
}
