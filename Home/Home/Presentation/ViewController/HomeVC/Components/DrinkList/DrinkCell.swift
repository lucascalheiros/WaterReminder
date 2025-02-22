//
//  DrinkListCell.swift
//  Home
//
//  Created by Lucas Calheiros on 08/02/25.
//

import Common
import UIKit
import Components

class DrinkCell: IdentifiableUICollectionViewCell {
    static let identifier: String = "DrinkListCell"

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

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addConstrainedSubviews(titleLabel)
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.backgroundColor = DefaultComponentsTheme.current.surface.color

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        color = DefaultComponentsTheme.current.surface.onColor
        title = ""
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
