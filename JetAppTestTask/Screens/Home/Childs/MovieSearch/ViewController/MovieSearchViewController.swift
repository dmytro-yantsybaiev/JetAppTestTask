//
//  MovieSearchViewController.swift
//  JetAppTestTask
//
//  Created by Dmytro Yantsybaiev on 10.12.2023.
//

import UIKit
import Combine
import JADataSource

final class MovieSearchViewController: UIViewController, Storyboardable {

    @IBOutlet private weak var controller: MovieSearchController!

    var viewModel: MovieSearchViewModel!
    var navigator: HomeNavigator!

    private let serchMovieSubject = PassthroughSubject<String, Never>()

    private var cancellable = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bind()
    }

    private func configure() {
        controller.configure()
    }

    private func bind() {
        let input = MovieSearchViewModel.Input(searchMoviePublisher: serchMovieSubject.eraseToAnyPublisher())
        let output = viewModel.transform(input)

        output
            .searchedMoviesPublisher
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] result in
                processSearchedMovies(result)
            }
            .store(in: &cancellable)

        controller
            .searchBar
            .searchTextField
            .textPublisher
            .throttle(for: .seconds(1), scheduler: DispatchQueue.main, latest: true)
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [unowned self] text in
                serchMovieSubject.send(text)
            })
            .store(in: &cancellable)
    }

    private func processSearchedMovies(_ result: Result<MoviePage, Error>) {
        guard case .success(let moviePage) = result else {
            return
        }
        controller.update(moviePage.movies)
    }
}
