//
//  UIApplication+Extension.swift
//  JetAppTestTask
//
//  Created by Dmytro Yantsybaiev on 11.12.2023.
//

import UIKit

extension UIApplication {

    static func topViewController(base viewController: UIViewController? = UIWindow.key?.rootViewController) -> UIViewController? {
        if let navigationController = viewController as? UINavigationController {
            return topViewController(base: navigationController.visibleViewController)
        }

        if let tabBarController = viewController as? UITabBarController, let selected = tabBarController.selectedViewController {
            return topViewController(base: selected)
        }

        if let presentedViewController = viewController?.presentedViewController {
            return topViewController(base: presentedViewController)
        }

        return viewController
    }
}

extension UIWindow {

    static var key: UIWindow? {
        let connectedScenes = UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }

        let window = connectedScenes.first?
            .windows
            .first { $0.isKeyWindow }

        return window
    }
}
