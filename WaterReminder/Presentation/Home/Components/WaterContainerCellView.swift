//
//  WaterContainerCell.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 14/05/23.
//

import Foundation
import UIKit


class WaterContainerCellView: UICollectionViewCell {
    
    private var listener: () -> Void = {}
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])
        return label
    }()
    
    private lazy var volumeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
        return label
    }()
    
    
    @objc func tapDetected() {
        listener()
    }
    
    func bindData(waterContainer: WaterSource) {
        titleLabel.text = waterContainer.waterSourceType.rawValue
        volumeLabel.text = waterContainer.volume.toML()
    }
    
    func bindListener(clickListener: @escaping () -> Void) {
        listener = clickListener
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = Theme.LightBlue.mainColor
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(tapDetected))
        contentView.addGestureRecognizer(singleTap)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

