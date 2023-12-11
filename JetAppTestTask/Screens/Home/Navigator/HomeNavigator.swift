//
//  HomeNavigator.swift
//  JetAppTestTask
//
//  Created by Dmytro Yantsybaiev on 09.12.2023.
//

final class HomeNavigator: BaseNavigator, Navigatable {

    enum Destination {
        case home
        case movieSearch
    }

    func navigate(to destination: Destination) {
        switch destination {
        case .home:
            toHome()
        case .movieSearch:
            toMovieSearch()
        }
    }

    private func toHome() {
        let viewController = HomeViewController.instantiate()
        viewController.viewModel = HomeViewModel()
        viewController.navigator = self
        navigate(to: viewController, type: .asRoot)
    }

    private func toMovieSearch() {
        let viewController = MovieSearchViewController.instantiate()
        viewController.viewModel = MovieSearchViewModel()
        viewController.navigator = self
        present(viewController)
    }
}
