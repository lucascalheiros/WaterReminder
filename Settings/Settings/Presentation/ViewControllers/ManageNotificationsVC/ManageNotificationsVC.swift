//
//  ManageNotificationsVC.swift
//  Settings
//
//  Created by Lucas Calheiros on 22/11/23.
//

import UIKit
import Core
import WaterReminderNotificationDomain
import Common
import Combine

class ManageNotificationsVC: UITableViewController {
    typealias DataSource = UITableViewDiffableDataSource<Sections, SectionItems>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Sections, SectionItems>

    var bag = Set<AnyCancellable>()

    let manageNotificationsViewModel: ManageNotificationsViewModel

    lazy var diffableDatasource: DataSource = makeDatasource()

    init(manageNotificationsViewModel: ManageNotificationsViewModel) {
        self.manageNotificationsViewModel = manageNotificationsViewModel
        super.init(style: .insetGrouped)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    static func newInstance(manageNotificationsViewModel: ManageNotificationsViewModel) -> ManageNotificationsVC {
        ManageNotificationsVC(manageNotificationsViewModel: manageNotificationsViewModel)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = String(localized: "manageNotifications.title", table: "Settings")
        view.backgroundColor = AppColorGroup.background.color

        tableView.dataSource = diffableDatasource

        manageNotificationsViewModel.$fixedNotification.combineLatest(manageNotificationsViewModel.$weekDaysState)
            .receive(on: DispatchQueue.main)
            .sink { notifications, weekDays in
                self.applySnapshot(
                    weekDays.map { SectionItems.weekDaysItem($0) } +
                    notifications.map { SectionItems.fixedNotificationItem($0) } +
                    [.addFixedNotification]
                )

        }.store(in: &bag)

        registerCells()
    }
}
