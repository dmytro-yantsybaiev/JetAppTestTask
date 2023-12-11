//
//  AppDelegate.swift
//  JetAppTestTask
//
//  Created by Dmytro Yantsybaiev on 09.12.2023.
//

import UIKit
import JADataSource
import JADomain

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        InjectionBundle.load { resolver in

            // Common
            resolver.single { Cache<URL, UIImage>() }

            // Repositories
            resolver.single { MovieRepository() }

            // Use Cases
            resolver.factory { TopRatedMoviesUseCase(repository: resolver.resolve()) }
            resolver.factory { SearchMovieUseCase(repository: resolver.resolve()) }
        }

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}
