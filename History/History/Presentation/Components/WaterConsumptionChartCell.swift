//
//  WaterConsumptionChartCell.swift
//  History
//
//  Created by Lucas Calheiros on 24/12/23.
//

import UIKit
import RxRelay
import RxSwift
import Core
import Components
import WaterManagementDomain
import SwiftUI
import Common
import Combine

class WaterConsumptionChartCell: IdentifiableUICollectionViewCell {
    static let identifier = "WaterConsumptionChartCell"
    var cancellableBag = Set<AnyCancellable>()
	let disposeBag = DisposeBag()

    var host: UIHostingController<HistoryChart>?

	override init(frame: CGRect) {
		super.init(frame: frame)
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 300)
        ])
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    override func prepareForReuse() {
        super.prepareForReuse()
        cancellableBag.removeAll()
    }

    func bind(in parent: UIViewController, viewModel: HistoryChartViewModel) {
        let view = HistoryChart(viewModel: viewModel)
        if let host = self.host {
            host.rootView = view

            host.view.layoutIfNeeded()
        } else {
            let host = UIHostingController(rootView: view)
            parent.addChild(host)
            host.didMove(toParent: parent)

            host.view.frame = CGRect(origin: .zero, size: CGSize(width: contentView.bounds.width, height: 300))
            self.contentView.addSubview(host.view)

            self.host = host
        }
    }

    deinit {
        host?.willMove(toParent: nil)
        host?.view.removeFromSuperview()
        host?.removeFromParent()
        host = nil
    }

}
