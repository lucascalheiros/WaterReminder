//
//  UIFont+Resources.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 07/11/23.
//

import UIKit

public extension UIFont {

    static var h1: UIFont {
        .systemFont(ofSize: 40)
    }

    static var h2: UIFont {
        .systemFont(ofSize: 30)
    }

    static var h3: UIFont {
        .systemFont(ofSize: 25)
    }

    static var h4: UIFont {
        .systemFont(ofSize: 20)
    }

    static var body: UIFont {
        .systemFont(ofSize: 16)
    }

    static var caption: UIFont {
        .systemFont(ofSize: 15)
    }

    static var screenTitle: UIFont {
        .h4.bold()
    }

    static var sectionTitle: UIFont {
        .h4.bold()
    }

    static var buttonBig: UIFont {
        .h4.bold()
    }

    static var buttonDefault: UIFont {
        .body.bold()
    }

}

extension UIFont {
    public func bold() -> UIFont {
        let descriptor = fontDescriptor.withSymbolicTraits(.traitBold) ?? fontDescriptor
        return UIFont(descriptor: descriptor, size: pointSize)
    }
}
