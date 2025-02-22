//
//  DrinkChips.swift
//  Home
//
//  Created by Lucas Calheiros on 08/02/25.
//

import Common
import UIKit
import Components

class DrinkChips: ProgrammaticView {

    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }

    var color: UIColor = DefaultComponentsTheme.current.surface.onColor {
        didSet {
            titleLabel.textColor = color
        }
    }

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .body
        label.textColor = DefaultComponentsTheme.current.surface.onColor
        return label
    }()

    override var intrinsicContentSize: CGSize {
        let labelSize = titleLabel.intrinsicContentSize
        return CGSize(width: labelSize.width + 16, height: labelSize.height + 16)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        addConstrainedSubviews(titleLabel)
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        backgroundColor = DefaultComponentsTheme.current.surface.color

        setContentHuggingPriority(.required, for: .horizontal)
        setContentCompressionResistancePriority(.required, for: .horizontal)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
