//
//  ViewController.swift
//  WaterReminder
//
//  Created by Lucas Calheiros on 07/05/23.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    lazy var waterContainerTableView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.backgroundColor = .clear
        collectionView.register(
            WaterPercentageHeaderView.self,
            forCellWithReuseIdentifier: "WaterPercentageHeaderView"
        )
        collectionView.register(
            WaterSourceListHorizontalCollectionView.self,
            forCellWithReuseIdentifier: "WaterSourceListHorizontalCollectionView"
        )
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

	var viewModel: HomeViewModel!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal

        view.addSubview(waterContainerTableView)

        NSLayoutConstraint.activate([
            waterContainerTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            waterContainerTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            waterContainerTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            waterContainerTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])

		// Define the custom actions.
		let acceptAction = UNNotificationAction(identifier: "ACCEPT_ACTION",
												title: "Accept",
												options: [])
		let declineAction = UNNotificationAction(identifier: "DECLINE_ACTION",
												 title: "Decline",
												 options: [])
		// Define the notification type
		let meetingInviteCategory =
		UNNotificationCategory(identifier: "MEETING_INVITATION",
							   actions: [acceptAction, declineAction],
							   intentIdentifiers: [],
							   hiddenPreviewsBodyPlaceholder: "",
							   options: .customDismissAction)
		// Register the notification type.
		let notificationCenter = UNUserNotificationCenter.current()
		notificationCenter.setNotificationCategories([meetingInviteCategory])

		UNUserNotificationCenter.current().requestAuthorization(
			options: [.alert, .badge, .sound]) { success, error in
				let content = UNMutableNotificationContent()
				content.title = "Weekly Staff Meeting"
				content.body = "Every Tuesday at 2pm"
				content.categoryIdentifier = "MEETING_INVITATION"
				// Configure the recurring date.
				var dateComponents = DateComponents()
				dateComponents.calendar = Calendar.current
				dateComponents.hour = 22    // 14:00 hours
				dateComponents.minute = 02

				// Create the trigger as a repeating event.
				let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

				// Create the request
				let uuidString = UUID().uuidString
				let request = UNNotificationRequest(identifier: uuidString,
													content: content, trigger: trigger)

				// Schedule the request with the system.
				let notificationCenter = UNUserNotificationCenter.current()
				notificationCenter.add(request) { (error) in
					if error != nil {
						// Handle any errors.
					}
				}
			}
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        default:
            fatalError("init(coder:) has not been implemented")
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "WaterPercentageHeaderView",
                for: indexPath
            )
            
            if let cell = cell as? WaterPercentageHeaderView {
                viewModel.consumedPercentage.subscribe(onNext: { percentage in
                    cell.setPercentage(percentage: percentage)
                }).disposed(by: cell.disposeBag)
                viewModel.consumedQuantityText.subscribe(onNext: { text in
                    cell.setSecondaryText(text: text)
                }).disposed(by: cell.disposeBag)
            }

            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "WaterSourceListHorizontalCollectionView",
                for: indexPath
            )
            
            if let cell = cell as? WaterSourceListHorizontalCollectionView {
                viewModel.waterSourceList.subscribe(onNext: {
                    cell.applySnapshot(waterContainerList: $0)
                }, onError: {
                    print($0)
                }).disposed(by: cell.disposeBag)
                
                cell.waterSourceListener = WaterSourceListener(
                    itemClickListener: {
                        self.viewModel.addWaterVolume(waterSource: $0)
                    },
                    pinClickListener: {
                        self.viewModel.updateWaterSourcePinState(waterSource: $0)
                    }
                )
            }

            return cell
        default:
            fatalError("init(coder:) has not been implemented")
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let horizontalPadding = insetBySection(section: indexPath.section).horizontalPadding()

        switch indexPath.section {
        case 0:
            return CGSize(width: collectionView.bounds.width - horizontalPadding, height: 300)
        case 1:
            return CGSize(width: collectionView.bounds.width, height: 248)
        default:
            fatalError("init(coder:) has not been implemented")
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 16
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        insetBySection(section: section)
    }

    private func insetBySection(section: Int) -> UIEdgeInsets {
        switch section {
        case 0:
            return UIEdgeInsets.vertical(inset: 8).horizontal(inset: 16)
        case 1:
            return UIEdgeInsets.set(inset: 0)
        default:
            fatalError("init(coder:) has not been implemented")
        }
    }

}
