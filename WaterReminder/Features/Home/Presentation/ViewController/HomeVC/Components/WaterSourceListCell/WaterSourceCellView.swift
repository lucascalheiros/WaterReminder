//
//  WaterContainerCell.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 14/05/23.
//

import Foundation
import UIKit
import RxRelay
import RxSwift
import Core

class WaterSourceCellView: UICollectionViewCell {
	let disposeBag = DisposeBag()

    var listener: WaterSourceListener?

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .h4
        label.textColor = AppColorGroup.surface.onColor
        return label
    }()

    private lazy var volumeLabel: UILabel = {
        let label = UILabel()
        label.font = .h3
        label.textColor = AppColorGroup.surface.onColor
        return label
    }()

	let volumeFormat = BehaviorRelay<VolumeFormat?>(value: nil)
	let waterSource = BehaviorRelay<WaterSource?>(value: nil)

	func bindData(_ waterSource: WaterSource, _ format: VolumeFormat) {
		let waterWithFormat = WaterWithFormat(waterInML: waterSource.volume, volumeFormat: format)
        titleLabel.text = waterSource.waterSourceType.exhibitionName
		volumeLabel.text = waterWithFormat.exhibitionValueWithFormat()
		titleLabel.textColor = waterSource.waterSourceType.color
		volumeLabel.textColor = waterSource.waterSourceType.color
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

		Observable.combineLatest(volumeFormat, waterSource).subscribe(onNext: { [weak self] format, waterSource in
			if let format, let waterSource {
				self?.bindData(waterSource, format)
			}
		}).disposed(by: disposeBag)

		contentView.addConstrainedSubviews(titleLabel, volumeLabel)
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = AppColorGroup.surface.color
        contentView.addGestureRecognizer(
			UITapGestureRecognizer(target: self, action: #selector(tapItemDetected))
		)

		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
			titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			volumeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
			volumeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
		])
    }

	@objc func tapItemDetected() {
		if let data = waterSource.value {
			listener?.itemClickListener(data)
		}
	}

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct WaterSourceListener {
    var itemClickListener: WaterSourceRunnable
    var pinClickListener: WaterSourceRunnable

    internal init(
        itemClickListener: @escaping WaterSourceRunnable,
        pinClickListener: @escaping WaterSourceRunnable
    ) {
        self.itemClickListener = itemClickListener
        self.pinClickListener = pinClickListener
    }
}

typealias WaterSourceRunnable = (WaterSource) -> Void
