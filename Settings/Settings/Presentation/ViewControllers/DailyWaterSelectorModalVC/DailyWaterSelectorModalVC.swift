//
//  DailyWaterSelectorModalVC.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 21/07/23.
//

import UIKit
import Common
import Components
import Core
import WaterManagementDomain
import Combine

class DailyWaterSelectorModalVC: UIViewController {
    var cancellableBag = Set<AnyCancellable>()

	let dailyWaterSelectorDelegate: DailyWaterSelectorDelegate

	private lazy var dailyWaterEditText = InputFieldWithSuffix()

	private var lastVolumeFormat: SystemFormat?

	private lazy var volumeFormatSegmentationControl = {
		let button = UISegmentedControl(items: SystemFormat.allCases.map { $0.localizedDisplay })
        button.backgroundColor = DefaultComponentsTheme.current.surface.color
		let normalAttr = [
            NSAttributedString.Key.foregroundColor: DefaultComponentsTheme.current.surface.onColor,
            NSAttributedString.Key.font: DefaultComponentsTheme.current.body
		]
        let selectedAttr = [
            NSAttributedString.Key.foregroundColor: DefaultComponentsTheme.current.primary.onColor,
            NSAttributedString.Key.font: DefaultComponentsTheme.current.body
        ]
		button.setTitleTextAttributes(normalAttr, for: .normal)
		button.setTitleTextAttributes(selectedAttr, for: .selected)
        button.selectedSegmentTintColor = DefaultComponentsTheme.current.primary.color
        button.addTarget(self, action: #selector(onVolumeFormatChange), for: .valueChanged)
		return button
	}()

    lazy var cancel = {
        let btn = UIBarButtonItem(
            title: String(localized: "generic.cancel"),
            primaryAction: .init(handler: { _ in
                self.dismiss(animated: true)
            })
        )
        btn.tintColor = DefaultComponentsTheme.current.background.onColor
        return btn
    }()

    lazy var confirm = {
        let btn = UIBarButtonItem(
            title: String(localized: "generic.confirm"), image: nil,
            primaryAction: .init(handler: { _ in
                let waterVolume = self.dailyWaterEditText.text?.toFloat() ?? 0
                self.dailyWaterSelectorDelegate.setVolumeAndFormat(
                    waterVolume,
                    (SystemFormat(rawValue:  self.volumeFormatSegmentationControl.selectedSegmentIndex) ?? SystemFormat.metric)
                )
                self.dismiss(animated: true)
            })
        )
        btn.tintColor = DefaultComponentsTheme.current.background.onColor
        return btn
    }()

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

        dailyWaterSelectorDelegate.volumeWithFormat.first().sinkUI { volumeWithFormat in
            self.dailyWaterEditText.text = volumeWithFormat.formattedValue
            self.dailyWaterEditText.suffix.text = volumeWithFormat.unit.formatted
            self.lastVolumeFormat = volumeWithFormat.unit.system
			self.volumeFormatSegmentationControl.selectedSegmentIndex = volumeWithFormat.unit.system.rawValue
        }.store(in: &cancellableBag)

        view.backgroundColor = DefaultComponentsTheme.current.background.color

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

    @objc private func onVolumeFormatChange() {
        let index = volumeFormatSegmentationControl.selectedSegmentIndex
        if index == -1 {
            return
        }
        let format = (SystemFormat(rawValue: index) ?? SystemFormat.metric)
        self.dailyWaterEditText.suffix.text = format.formatDisplay
        if let lastVolumeFormat = self.lastVolumeFormat {
            let lastVolumeInML = self.lastVolumeFormat?.toMetric(self.dailyWaterEditText.text?.toFloat() ?? 0.0) ?? 0
            self.dailyWaterEditText.text = Volume(lastVolumeInML, .milliliters).to(format).formattedValue
        }
        self.lastVolumeFormat = format

    }
}
