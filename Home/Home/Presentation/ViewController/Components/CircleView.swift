//
//  CircleView.swift
//  Home
//
//  Created by Lucas Calheiros on 22/02/25.
//

import UIKit
import Common

class CircleView: ProgrammaticView {

    var color: UIColor = .blue {
        didSet {
            setupView()
        }
    }

    var strokeColor: UIColor = .white {
        didSet {
            setupView()
        }
    }


    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    private func setupView() {
        backgroundColor = color
        layer.cornerRadius = bounds.size.width / 2
        layer.borderColor = strokeColor.cgColor
        layer.borderWidth = 5
        clipsToBounds = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }
}
