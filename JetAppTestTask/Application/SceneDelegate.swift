//
//  SceneDelegate.swift
//  JetAppTestTask
//
//  Created by Dmytro Yantsybaiev on 09.12.2023.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private var appNavigator: AppNavigator?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }

        window = UIWindow(windowScene: windowScene)
        appNavigator = AppNavigator(window, UINavigationController())
        appNavigator?.navigate(to: .main)
    }
}
