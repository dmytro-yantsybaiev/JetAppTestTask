//
//  HomeViewModel.swift
//  JetAppTestTask
//
//  Created by Dmytro Yantsybaiev on 09.12.2023.
//

import UIKit
import Combine
import JADomain
import JADataSource

final class HomeViewModel: ViewModelType {

    struct Input {
        let fetchTopMoviesPublisher: AnyPublisher<Void, Never>
        let refreshTopMoviesPublisher: AnyPublisher<Void, Never>
        let countCharactersOccurancePublisher: AnyPublisher<[Movie], Never>
    }

    struct Output {
        let topMoviesPublisher: AnyPublisher<MoviePage, Error>
        let refreshedTopMoviesPublisher: AnyPublisher<MoviePage, Error>
        let charactersOccurancePublisher: AnyPublisher<[Character: Int], Never>
        let isLoadingPublisher: AnyPublisher<Bool, Never>
    }

    @Injected private var topRatedMoviesUseCase: TopRatedMoviesUseCase

    func transform(_ input: Input) -> Output {
        let isLoading = CurrentValueSubject<Bool, Never>(false)

        let topMovies = input.fetchTopMoviesPublisher
            .trackLoading(isLoading)
            .flatMap { [unowned self] in
                topRatedMoviesUseCase.execute()
            }
            .eraseToAnyPublisher()
            .trackFinished(isLoading)

        let refreshedTopMovies = input.refreshTopMoviesPublisher
            .flatMap { [unowned self] in
                topRatedMoviesUseCase.execute()
            }
            .eraseToAnyPublisher()

        let charactersOccurance = input.countCharactersOccurancePublisher
            .map { movies in
                var characterCounts = [Character: Int]()
                for movie in movies {
                    for character in movie.title {
                        characterCounts[character, default: 0] += 1
                    }
                }
                return characterCounts
            }

        return Output(
            topMoviesPublisher: topMovies.eraseToAnyPublisher(), 
            refreshedTopMoviesPublisher: refreshedTopMovies.eraseToAnyPublisher(), 
            charactersOccurancePublisher: charactersOccurance.eraseToAnyPublisher(),
            isLoadingPublisher: isLoading.eraseToAnyPublisher()
        )
    }
}
