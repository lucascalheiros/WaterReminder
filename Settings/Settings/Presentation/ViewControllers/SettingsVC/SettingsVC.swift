//
//  SettingsVC.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 14/05/23.
//

import UIKit
import Common
import Components
import Combine

class SettingsVC: UITableViewController {
    static func newInstance(settingsViewModel: SettingsViewModel) -> SettingsVC {
        SettingsVC(settingsViewModel: settingsViewModel)
    }
    
    let settingsViewModel: SettingsViewModel
    var cancellableBag = Set<AnyCancellable>()

    lazy var diffableDatasource: DataSource = makeDatasource()

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
        applySnapshot()
	}

    func prepareConfiguration() {
        view.backgroundColor = DefaultComponentsTheme.current.background.color
        tableView.dataSource = diffableDatasource
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = DefaultComponentsTheme.current.surface.onColor
        registerCells()
    }
}
