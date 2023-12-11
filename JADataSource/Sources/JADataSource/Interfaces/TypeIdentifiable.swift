//
//  TypeIdentifiable.swift
//
//
//  Created by Dmytro Yantsybaiev on 09.12.2023.
//

import UIKit

public protocol TypeIdentifiable {

    static var nib: UINib { get }
    static var nibName: String { get }
}

public extension TypeIdentifiable {

    static var nib: UINib {
        return UINib(nibName: nibName, bundle: nil)
    }

    static var nibName: String {
        return String(describing: self)
    }
}
