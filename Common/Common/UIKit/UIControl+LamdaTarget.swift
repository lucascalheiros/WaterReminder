//
//  UIControl+LamdaTarget.swift
//  Common
//
//  Created by Lucas Calheiros on 05/02/25.
//

import UIKit

public final class SimplifiedUIControlEvent {

    private let action: () -> Void

    init(view: UIControl, action: @escaping () -> Void, for controlEvents: UIControl.Event) {
        self.action = action
        view.addTarget(self, action: #selector(execute), for: controlEvents)
    }

    @objc private func execute() {
        action()
    }
}


public extension UIControl {
    func addEvent(_ controlEvents: UIControl.Event, _ runnable: @escaping () -> Void) {
        let event = SimplifiedUIControlEvent(view: self, action: runnable, for: controlEvents)
    }
}
