//
//  AddFixedNotificationVC.swift
//  Settings
//
//  Created by Lucas Calheiros on 01/12/23.
//

import UIKit
import Common
import Components
import Core

class AddFixedNotificationVC: UIViewController {

    static func newInstance(addFixedNotificationViewModel: AddFixedNotificationViewModel) -> AddFixedNotificationVC {
        AddFixedNotificationVC(addFixedNotificationViewModel: addFixedNotificationViewModel)
    }
    
    let addFixedNotificationViewModel: AddFixedNotificationViewModel
    lazy var dayTimeSelector = DayTimeSelectorPickerView()

    lazy var cancel = {
        let btn = UIBarButtonItem(title: String(localized: "generic.cancel"), primaryAction: .init(handler: { _ in
            self.dismiss(animated: true)
        }))
        btn.tintColor = .white
        return btn
    }()

    lazy var confirm = {
        let btn = UIBarButtonItem(title: String(localized: "generic.confirm"), image: nil, primaryAction: .init(handler: { _ in
            self.addFixedNotificationViewModel.addFixedNotification(self.dayTimeSelector.dayTime)
            self.dismiss(animated: true)
        }))
        btn.tintColor = .white
        return btn
    }()

    init(addFixedNotificationViewModel: AddFixedNotificationViewModel) {
        self.addFixedNotificationViewModel = addFixedNotificationViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        title = String(localized: "addFixedNotification.title", table: "Settings")
        view.backgroundColor = AppColorGroup.background.color
        navigationItem.leftBarButtonItem = cancel
        navigationItem.rightBarButtonItem = confirm
        prepareConstraints()
    }

    func prepareConstraints() {
        view.addConstrainedSubviews(dayTimeSelector)

        NSLayoutConstraint.activate([
            dayTimeSelector.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dayTimeSelector.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
