//
//  ActivityLevelCard.swift
//  FirstAccess
//
//  Created by Lucas Calheiros on 05/02/25.
//

import Common
import UIKit
import Core
import Components

class ActivityLevelCardView: ProgrammaticView {

    var isSelected: Bool = false {
        didSet {
            UIView.animate(
                withDuration: 0.5,
                animations: { [weak self] in
                    guard let self else { return }
                    if isSelected {
                        checkedImage.isHidden = false
                        layer.borderWidth = 1
                        checkedImage.alpha = 1
                    } else {
                        layer.borderWidth = 0
                        checkedImage.alpha = 0
                    }
                }, completion: { [weak self] _ in
                    guard let self else { return }
                    checkedImage.isHidden = !isSelected
                })
        }
    }

    private lazy var checkedImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "checkmark.circle.fill"))
        image.isHidden = true
        image.tintColor = AppColorGroup.surface.onColor
        return image
    }()


    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = DefaultComponentsTheme.current.h3
        label.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .max
        label.font = DefaultComponentsTheme.current.h4
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
    }()


    convenience init(title: String, description: String) {
        self.init()
        titleLabel.text = title
        descriptionLabel.text = description
    }

    override func prepareConfiguration() {
        layer.cornerRadius = 8
        backgroundColor = AppColorGroup.surface.color
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderColor = AppColorGroup.surface.onColor.cgColor
    }

    override func prepareConstraints() {
        addConstrainedSubviews(stackView, checkedImage)
        stackView.addConstrainedArrangedSubviews(titleLabel, descriptionLabel)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),

            checkedImage.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            checkedImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            titleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

}
