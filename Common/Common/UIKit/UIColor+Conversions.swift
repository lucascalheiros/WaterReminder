//
//  UIColor+Conversions.swift
//  Common
//
//  Created by Lucas Calheiros on 24/12/23.
//

import UIKit
import SwiftUI

public extension UIColor {
    var suColor: Color {
        Color(self)
    }

    var intValue: Int {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return Int(r * 0xFF) << 16 | Int(g * 0xFF) << 8 | Int(b * 0xFF)
    }
}

public extension Int {
    var toColor: UIColor {
        let red =   CGFloat((self & 0xFF0000) >> 16) / 0xFF
        let green = CGFloat((self & 0x00FF00) >> 8) / 0xFF
        let blue =  CGFloat(self & 0x0000FF) / 0xFF
        let alpha = CGFloat(1.0)

        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}


public extension Int64 {
    var toColor: UIColor {
        let red =   CGFloat((self & 0xFF000000) >> 24) / 0xFF
        let green = CGFloat((self & 0x00FF0000) >> 16) / 0xFF
        let blue =  CGFloat((self & 0x0000FF00) >> 8) / 0xFF
        let alpha = CGFloat(self & 0x000000FF) / 0xFF

        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
