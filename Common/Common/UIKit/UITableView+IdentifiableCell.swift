//
//  UITableView+IdentifiableCell.swift
//  Common
//
//  Created by Lucas Calheiros on 25/11/23.
//

import UIKit

public typealias IdentifiableUITableViewCell = UITableViewCell & IdentifiableCell

public extension UITableView {
    func registerIdentifiableCell<T: IdentifiableUITableViewCell>(_ cellClass: T.Type) {
        register(
            cellClass.self,
            forCellReuseIdentifier: cellClass.identifier
        )
    }

    func dequeueIdentifiableCell<T: IdentifiableUITableViewCell>(_ indexPath: IndexPath, _ onDequeue: (T) -> Void) -> T {
        if let cell = dequeueReusableCell(
            withIdentifier: T.identifier,
            for: indexPath
        ) as? T {
            onDequeue(cell)
            return cell
        }
        fatalError("Cell identifier: \(T.identifier) don't match respective IdentifiableUITableViewCell")
    }
}
