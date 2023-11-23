//
//  UIFont+Resources.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 07/11/23.
//

import UIKit

public extension UIFont {

    static var h1: UIFont {
        .boldSystemFont(ofSize: 40)
    }

    static var h2: UIFont {
        .boldSystemFont(ofSize: 30)
    }

    static var h3: UIFont {
        .boldSystemFont(ofSize: 25)
    }

    static var h4: UIFont {
        .boldSystemFont(ofSize: 20)
    }

    static var body: UIFont {
        .boldSystemFont(ofSize: 16)
    }

    static var caption: UIFont {
        .boldSystemFont(ofSize: 15)
    }

    static var screenTitle: UIFont {
        .h4
    }

    static var sectionTitle: UIFont {
        .h4
    }

    static var buttonBig: UIFont {
        .h4
    }

    static var buttonDefault: UIFont {
        .body
    }

}
