//
//  CardStackView.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 11/05/23.
//

import Foundation
import UIKit


class CardStackView: UIStackView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        layer.cornerRadius = 8
        backgroundColor = .white.withAlphaComponent(0.5)
    }
    
}
