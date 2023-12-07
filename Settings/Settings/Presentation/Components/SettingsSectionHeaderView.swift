//
//  SettingsSectionHeaderView.swift
//  Settings
//
//  Created by Lucas Calheiros on 25/11/23.
//

import Common
import UIKit

class SettingsSectionHeaderView: ProgrammaticView {

    private lazy var titleLabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = .sectionTitle
        return label
    }()

    func setTitle(text: String) {
        titleLabel.text = text
    }

    override func prepareConstraints() {
        addConstrainedSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
        ])
    }
}
