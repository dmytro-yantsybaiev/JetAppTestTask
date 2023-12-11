//
//  AppNavigator.swift
//  JetAppTestTask
//
//  Created by Dmytro Yantsybaiev on 09.12.2023.
//

import UIKit

final class AppNavigator: Navigatable {

    enum Destination {
        case main
    }

    private let navigationController: UINavigationController

    init(_ window: UIWindow?, _ navigationController: UINavigationController) {
        self.navigationController = navigationController
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    func navigate(to destination: Destination) {
        switch destination {
        case .main:
            toMain()
        }
    }

    private func toMain() {
        let homeNavigator = HomeNavigator(navigationController)
        homeNavigator.navigate(to: .home)
    }
}
