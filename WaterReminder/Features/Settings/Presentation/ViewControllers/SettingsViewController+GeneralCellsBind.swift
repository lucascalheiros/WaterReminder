//
//  SettingsViewController+GeneralCellsBind.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 30/07/23.
//

import UIKit

extension SettingsViewController {
	func bindDailyWaterGoalCell(detailCell: SettingsDetailTableViewCell, sectionItem: any SectionItem) {
		detailCell.dispose()
		detailCell.titleLabel.text = sectionItem.itemTitle()
		detailCell.detailLabel.font = UIFont.boldSystemFont(ofSize: 16)
		detailCell.detailLabel.textColor = .blue

		settingsViewModel.dailyWaterSelectorDelegate.volumeWithFormat.subscribe(onNext: {
			let attributedString = NSMutableAttributedString.init(string: $0.exhibitionValueWithFormat())
			detailCell.detailLabel.attributedText = attributedString
		}).disposed(by: detailCell.disposeBag)
	}

}
