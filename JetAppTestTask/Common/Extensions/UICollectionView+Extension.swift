//
//  UICollectionView+Extension.swift
//  JetAppTestTask
//
//  Created by Dmytro Yantsybaiev on 10.12.2023.
//

import UIKit
import JADataSource

public extension UICollectionView {

    func register<T: TypeIdentifiable>(_ cell: T.Type) where T: UICollectionViewCell {
        register(cell.nib, forCellWithReuseIdentifier: cell.nibName)
    }

    func dequeueReusableCell<T>(_ indexPath: IndexPath) -> T where T: UICollectionViewCell, T: TypeIdentifiable {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.nibName, for: indexPath) as? T else {
            fatalError("Cell with \(T.nibName) identifier not registered")
        }
        return cell
    }
}
