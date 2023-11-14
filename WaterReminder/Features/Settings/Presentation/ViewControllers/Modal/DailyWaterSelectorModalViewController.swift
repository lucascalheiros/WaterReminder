//
//  DailyWaterSelectorModalViewController.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 21/07/23.
//

import RxCocoa
import RxSwift
import UIKit
import Common
import Components
import Core

class DailyWaterSelectorModalViewController: UIViewController {
	var disposeBag = DisposeBag()

	let dailyWaterSelectorDelegate: DailyWaterSelectorDelegate

	private lazy var dailyWaterEditText = InputFieldWithSuffix()

	private var lastVolumeFormat: VolumeFormat?

	private lazy var volumeFormatSegmentationControl = {
		let button = UISegmentedControl(items: VolumeFormat.allCases.map { $0.localizedDisplay })
		button.backgroundColor = AppColorGroup.surface.color
		let attributes = [
			NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.body
		]
		button.setTitleTextAttributes(attributes, for: .normal)
		button.setTitleTextAttributes(attributes, for: .selected)
		button.selectedSegmentTintColor = .blue
		button.rx.selectedSegmentIndex.bind {
			if $0 == -1 {
				return
			}
			let format = (VolumeFormat(rawValue: $0) ?? VolumeFormat.metric)
			self.dailyWaterEditText.suffix.text = format.formatDisplay
			if let lastVolumeFormat = self.lastVolumeFormat {
				let lastVolumeInML = self.lastVolumeFormat?.toMetric(self.dailyWaterEditText.text?.toFloat() ?? 0.0) ?? 0
				let waterWithFormat = WaterWithFormat(waterInML: Int(lastVolumeInML), volumeFormat: format)
				self.dailyWaterEditText.text = waterWithFormat.exhibitionValue()
			}
			self.lastVolumeFormat = format
		}.disposed(by: disposeBag)
		return button
	}()

	lazy var cancel = UIBarButtonItem(
		title: String(localized: "generic.cancel"),
		primaryAction: .init(handler: { _ in
			self.dismiss(animated: true)
		})
	)

	lazy var confirm = UIBarButtonItem(
		title: String(localized: "generic.confirm"), image: nil,
		primaryAction: .init(handler: { _ in
			let waterVolume = self.dailyWaterEditText.text?.toFloat() ?? 0
			self.dailyWaterSelectorDelegate.setVolumeAndFormat(
				waterVolume,
				(VolumeFormat(rawValue:  self.volumeFormatSegmentationControl.selectedSegmentIndex) ?? VolumeFormat.metric)
			)
			self.dismiss(animated: true)
		})
	)

	init(dailyWaterSelectorDelegate: DailyWaterSelectorDelegate) {
		self.dailyWaterSelectorDelegate = dailyWaterSelectorDelegate
		super.init(nibName: nil, bundle: nil)
	}

	@available(*, unavailable)
	required init?(coder _: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		dailyWaterSelectorDelegate.volumeWithFormat.safeAsSingle().subscribe( onSuccess: { volumeWithFormat in
			self.dailyWaterEditText.text = volumeWithFormat.exhibitionValue()
			self.dailyWaterEditText.suffix.text = volumeWithFormat.volumeFormat.formatDisplay
			self.lastVolumeFormat = volumeWithFormat.volumeFormat
			self.volumeFormatSegmentationControl.selectedSegmentIndex = volumeWithFormat.volumeFormat.rawValue

		}).disposed(by: disposeBag)

		view.backgroundColor = AppColorGroup.surface.color
		cancel.tintColor = .blue
		confirm.tintColor = .blue

		navigationItem.leftBarButtonItem = cancel
		navigationItem.rightBarButtonItem = confirm

		view.addConstrainedSubviews(dailyWaterEditText, volumeFormatSegmentationControl)

		NSLayoutConstraint.activate([
			dailyWaterEditText.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			dailyWaterEditText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			dailyWaterEditText.widthAnchor.constraint(equalToConstant: 180),
			dailyWaterEditText.heightAnchor.constraint(equalToConstant: 60),
			volumeFormatSegmentationControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			volumeFormatSegmentationControl.topAnchor.constraint(equalTo: dailyWaterEditText.bottomAnchor, constant: 8)
		])
	}
}
