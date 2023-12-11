//
//  BaseNavigator.swift
//  JetAppTestTask
//
//  Created by Dmytro Yantsybaiev on 09.12.2023.
//

import UIKit

class BaseNavigator {

    enum NavigateType {
        case `default`
        case asRoot
    }

    internal let navigationController: UINavigationController

    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    convenience init() {
        self.init(UINavigationController())
    }

    func dismiss(animated: Bool = true) {
        navigationController.dismiss(animated: animated)
    }

    func pop() {
        navigationController.popViewController(animated: true)
    }

    func popToRoot(animated: Bool = true) {
        navigationController.popToRootViewController(animated: animated)
    }

    func popTo(_ viewController: UIViewController) {
        navigationController.popToViewController(viewController, animated: true)
    }

    func present(_ viewController: UIViewController) {
        navigationController.present(viewController, animated: true)
    }

    func push(_ viewController: UIViewController, type: NavigateType = .default, animated: Bool = true) {
        switch type {
        case .default:
            navigationController.pushViewController(viewController, animated: animated)
        case .asRoot:
            navigationController.setViewControllers([viewController], animated: animated)
        }
    }
}
