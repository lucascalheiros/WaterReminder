//
//  UIView+AddTapListener.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 03/11/23.
//

import UIKit

public extension UIView {
    func addTapListener(_ runnable: @escaping () -> Void) {
        let tap = SimplifiedGestureRecognizer(action: runnable)
        self.addGestureRecognizer(tap)
    }
}
