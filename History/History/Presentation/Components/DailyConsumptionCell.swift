//
//  DailyConsumptionCell.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 10/08/23.
//

import UIKit
import Core
import Components
import WaterManagementDomain
import Common
import Combine

class DailyConsumptionCell: IdentifiableUICollectionViewCell {
    static let identifier = "DailyConsumptionCell"
    var cancellableBag = Set<AnyCancellable>()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = DefaultComponentsTheme.current.body
        label.textColor = DefaultComponentsTheme.current.surface.onColor
        return label
    }()
    
    private lazy var volumeLabel: UILabel = {
        let label = UILabel()
        label.font = DefaultComponentsTheme.current.body
        label.textColor = DefaultComponentsTheme.current.surface.onColor
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = DefaultComponentsTheme.current.body
        label.textColor = DefaultComponentsTheme.current.surface.onColor
        return label
    }()

    var consumedCupInfo: ConsumedCupInfo? {
        didSet {
            updateUI()
        }
    }

    var systemFormat: SystemFormat? {
        didSet {
            updateUI()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        prepareConfiguration()
        prepareConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cancellableBag.removeAll()
    }
    
    func prepareConfiguration() {
        contentView.backgroundColor = DefaultComponentsTheme.current.surface.color
    }
    
    func prepareConstraints() {
        contentView.addConstrainedSubviews(titleLabel, volumeLabel, timeLabel)
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 44),
            
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            
            volumeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            volumeLabel.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: 16),
            volumeLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 100),
            
            timeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }
    
    private func updateUI() {
        guard let systemFormat, let consumedCupInfo else { return }
        titleLabel.text = consumedCupInfo.drink.name
        titleLabel.textColor = consumedCupInfo.drink.color
        volumeLabel.textColor = consumedCupInfo.drink.color
        volumeLabel.text = Volume(consumedCupInfo.consumedCup.volume, .milliliters).to(systemFormat).formattedValueAndUnit
        timeLabel.text = consumedCupInfo.consumedCup.consumptionTime.formatted(date: .omitted, time: .shortened)
    }
}
