//
//  SettingsSectionHeaderView.swift
//  Settings
//
//  Created by Lucas Calheiros on 25/11/23.
//

import Common
import UIKit
import Components

class SettingsSectionHeaderView: ProgrammaticView {

    private lazy var titleLabel = {
        let label = UILabel()
        label.textColor = DefaultComponentsTheme.current.background.onColor
        label.font = .sectionTitle
        return label
    }()

    func setTitle(text: String) {
        titleLabel.text = text
    }

    override func prepareConstraints() {
        addConstrainedSubview(titleLabel)

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 50),

            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
        ])
    }
}
