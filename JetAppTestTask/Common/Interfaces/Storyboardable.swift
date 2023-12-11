//
//  Storyboardable.swift
//  JetAppTestTask
//
//  Created by Dmytro Yantsybaiev on 09.12.2023.
//

import UIKit

protocol Storyboardable {

    static var storyboardName: String { get }
}

extension Storyboardable where Self: UIViewController {

    static var storyboardName: String {
        return String(describing: self)
    }

    static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle(for: Self.self))

        guard let viewController = storyboard.instantiateInitialViewController() as? Self else {
            fatalError("Could not instantiate initial storyboard with name: \(storyboardName)")
        }

        return viewController
    }
}
