//
//  SettingsVC.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 14/05/23.
//

import UIKit
import RxCocoa
import RxSwift
import Common
import Components

class SettingsVC: UITableViewController {
    static func newInstance(settingsViewModel: SettingsViewModel) -> SettingsVC {
        SettingsVC(settingsViewModel: settingsViewModel)
    }
    
    let settingsViewModel: SettingsViewModel
	let disposeBag = DisposeBag()

	init(settingsViewModel: SettingsViewModel) {
		self.settingsViewModel = settingsViewModel
		super.init(style: .insetGrouped)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
        prepareConfiguration()
	}

    func prepareConfiguration() {
        view.backgroundColor = DefaultComponentsTheme.current.background.color
        registerCells()
    }
}
