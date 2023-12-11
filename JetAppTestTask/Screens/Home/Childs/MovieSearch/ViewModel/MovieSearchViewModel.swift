//
//  MovieSearchViewModel.swift
//  JetAppTestTask
//
//  Created by Dmytro Yantsybaiev on 10.12.2023.
//

import Combine
import JADataSource
import JADomain

final class MovieSearchViewModel: ViewModelType {

    struct Input {
        let searchMoviePublisher: AnyPublisher<String, Never>
    }

    struct Output {
        let searchedMoviesPublisher: AnyPublisher<MoviePage, Error>
    }

    @Injected private var searchMovieUseCase: SearchMovieUseCase

    func transform(_ input: Input) -> Output {
        let searchedMovies = input.searchMoviePublisher
            .flatMap { [unowned self] movieName in
                searchMovieUseCase.execute(with: movieName)
            }

        return Output(searchedMoviesPublisher: searchedMovies.eraseToAnyPublisher())
    }
}
