//
//  WaterContainerCell.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 14/05/23.
//

import Foundation
import UIKit


class WaterSourceCellView: UICollectionViewCell {
    
    var data: WaterSource!
    var listener: WaterSourceListener? = nil
    
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
    
    private lazy var pinButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        button.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
        ])
        return button
    }()
    
    @objc func tapItemDetected() {
        listener?.itemClickListener(data)
    }

    @objc func tapPinDetected() {
        listener?.pinClickListener(data)
    }
    
    func bindData(waterContainer: WaterSource) {
        titleLabel.text = waterContainer.waterSourceType.rawValue
        volumeLabel.text = waterContainer.volume.toML()
        setPinButtonIcon(isPinned: waterContainer.isPinned)
        data = waterContainer
    }

    func setPinButtonIcon(isPinned: Bool) {
        let image = UIImage(systemName: isPinned ? "pin.fill" : "pin")
        pinButton.setImage(image, for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = Theme.LightBlue.mainColor
        let singleTapItem = UITapGestureRecognizer(target: self, action: #selector(tapItemDetected))
        contentView.addGestureRecognizer(singleTapItem)
        let singleTapPin = UITapGestureRecognizer(target: self, action: #selector(tapPinDetected))
        pinButton.addGestureRecognizer(singleTapPin)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

struct WaterSourceListener {
    var itemClickListener: (WaterSource) -> Void
    var pinClickListener: (WaterSource) -> Void
    
    internal init(itemClickListener: @escaping (WaterSource) -> Void, pinClickListener: @escaping (WaterSource) -> Void) {
        self.itemClickListener = itemClickListener
        self.pinClickListener = pinClickListener
    }
}
