//
//  HomeNavigator.swift
//  JetAppTestTask
//
//  Created by Dmytro Yantsybaiev on 09.12.2023.
//

import JADataSource

final class HomeNavigator: BaseNavigator, Navigatable {

    enum Destination {
        case home
        case movieDetail(Movie)
        case movieSearch
    }

    func navigate(to destination: Destination) {
        switch destination {
        case .home:
            toHome()
        case .movieDetail(let movie):
            toMovieDetail(movie)
        case .movieSearch:
            toMovieSearch()
        }
    }

    private func toHome() {
        let viewController = HomeViewController.instantiate()
        viewController.viewModel = HomeViewModel()
        viewController.navigator = self
        push(viewController, type: .asRoot)
    }

    private func toMovieDetail(_ movie: Movie) {
        let viewController = MovieDetailViewController.instantiate()
        viewController.viewModel = MovieDetailViewModel()
        viewController.navigator = self
        viewController.movie = movie
        push(viewController)
    }

    private func toMovieSearch() {
        let viewController = MovieSearchViewController.instantiate()
        viewController.viewModel = MovieSearchViewModel()
        viewController.navigator = self
        present(viewController)
    }
}
