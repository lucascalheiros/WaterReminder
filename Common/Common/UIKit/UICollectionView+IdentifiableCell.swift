//
//  UICollectionView+IdentifiableCell.swift
//  Common
//
//  Created by Lucas Calheiros on 19/12/23.
//

import UIKit

public typealias IdentifiableUICollectionViewCell = IdentifiableCell & UICollectionViewCell

public extension UICollectionView {
    func registerIdentifiableCell<T: IdentifiableUICollectionViewCell>(_ cellClass: T.Type) {
        register(
            cellClass.self,
            forCellWithReuseIdentifier: cellClass.identifier
        )
    }

    func dequeueIdentifiableCell<T: IdentifiableUICollectionViewCell>(_ indexPath: IndexPath, _ onDequeue: (T) -> Void) -> T {
        if let cell = dequeueReusableCell(
            withReuseIdentifier: T.identifier,
            for: indexPath
        ) as? T {
            onDequeue(cell)
            return cell
        }
        fatalError("Cell identifier: \(T.identifier) don't match respective IdentifiableUICollectionViewCell")
    }
}
