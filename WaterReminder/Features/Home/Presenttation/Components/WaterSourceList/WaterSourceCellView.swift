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

class WaterSourceCellView: UICollectionViewCell {
	let disposeBag = DisposeBag()

    var listener: WaterSourceListener?

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.textColor = .darkGray
        return label
    }()

    private lazy var volumeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30.0)
        label.textColor = .darkGray
        return label
    }()

    private lazy var pinButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        return button
    }()

	let volumeFormat = BehaviorRelay<VolumeFormat?>(value: nil)
	let waterSource = BehaviorRelay<WaterSource?>(value: nil)

	func bindData(_ waterSource: WaterSource, _ format: VolumeFormat) {
		let waterWithFormat = WaterWithFormat(waterInML: waterSource.volume, volumeFormat: format)
        titleLabel.text = waterSource.waterSourceType.exhibitionName
		volumeLabel.text = waterWithFormat.exhibitionValueWithFormat()
		titleLabel.textColor = waterSource.waterSourceType.color
		volumeLabel.textColor = waterSource.waterSourceType.color
        setPinButtonIcon(isPinned: waterSource.isPinned)
    }

    func setPinButtonIcon(isPinned: Bool) {
        let image = UIImage(systemName: isPinned ? "pin.fill" : "pin")
        pinButton.setImage(image, for: .normal)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

		Observable.combineLatest(volumeFormat, waterSource).subscribe(onNext: { [weak self] format, waterSource in
			if let format, let waterSource {
				self?.bindData(waterSource, format)
			}
		}).disposed(by: disposeBag)

		contentView.addConstrainedSubviews(titleLabel, volumeLabel, pinButton)
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = Theme.lightBlue.mainColor
        contentView.addGestureRecognizer(
			UITapGestureRecognizer(target: self, action: #selector(tapItemDetected))
		)
        pinButton.addGestureRecognizer(
			UITapGestureRecognizer(target: self, action: #selector(tapPinDetected))
		)

		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
			titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			volumeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
			volumeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
			pinButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
			pinButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
		])
    }

	@objc func tapItemDetected() {
		if let data = waterSource.value {
			listener?.itemClickListener(data)
		}
	}

	@objc func tapPinDetected() {
		if let data = waterSource.value {
			listener?.pinClickListener(data)
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
