//
//  DailyWaterSelectorModalViewController.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 21/07/23.
//

import RxCocoa
import RxSwift
import UIKit

class DailyWaterSelectorModalViewController: UIViewController {
	var disposeBag = DisposeBag()

	let dailyWaterSelectorDelegate: DailyWaterSelectorDelegate

	private lazy var dailyWaterEditText = {
		let text = DailyWaterInputField()
		return text
	}()

	private var currentVolumeFormat = VolumeFormat.metric

	private lazy var volumeFormatSegmentationControl = {
		let button = UISegmentedControl(items: VolumeFormat.allCases.map { $0.localizedDisplay })
		dailyWaterEditText.suffix.text = VolumeFormat.metric.formatDisplay
		button.selectedSegmentIndex = 0
		button.backgroundColor = Theme.lightTeal.mainColor
		let attributes = [
			NSAttributedString.Key.foregroundColor: UIColor.white,
			NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16.0)
		]
		button.setTitleTextAttributes(attributes, for: .normal)
		button.setTitleTextAttributes(attributes, for: .selected)
		button.selectedSegmentTintColor = .blue
		button.rx.selectedSegmentIndex.bind {
			let format = (VolumeFormat(rawValue: $0) ?? VolumeFormat.metric)
			self.dailyWaterEditText.suffix.text = format.formatDisplay
			self.dailyWaterEditText.text = String(format: "%.1f", self.waterVolumeTo(format))
			self.currentVolumeFormat = format
		}.disposed(by: disposeBag)
		return button
	}()

	lazy var cancel = UIBarButtonItem(
		title: "Cancel",
		primaryAction: .init(handler: { _ in
			self.dismiss(animated: true)
		})
	)

	lazy var confirm = UIBarButtonItem(
		title: "Confirm", image: nil,
		primaryAction: .init(handler: { _ in
			let waterVolume = self.dailyWaterEditText.text?.toFloat() ?? 0
			self.dailyWaterSelectorDelegate.setVolumeAndFormat(waterVolume, self.currentVolumeFormat)
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
			self.dailyWaterEditText.text = String(volumeWithFormat.volumeFormat.fromMetric(Float(volumeWithFormat.waterInML)))
			self.currentVolumeFormat = volumeWithFormat.volumeFormat
			self.volumeFormatSegmentationControl.selectedSegmentIndex = volumeWithFormat.volumeFormat.rawValue
		}).disposed(by: disposeBag)

		view.backgroundColor = Theme.lightBlue.mainColor
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

	func waterVolumeInML() -> Float {
		let volume = self.dailyWaterEditText.text.unwrapLet { $0.toFloat() ?? 0 } ?? 0
		return currentVolumeFormat.toMetric(volume)
	}

	func waterVolumeTo(_ volumeFormat: VolumeFormat) -> Float {
		let volume = waterVolumeInML()
		return volumeFormat.fromMetric(volume)
	}
}
