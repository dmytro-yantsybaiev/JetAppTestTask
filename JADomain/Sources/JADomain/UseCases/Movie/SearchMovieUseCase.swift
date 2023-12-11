//
//  SearchMovieUseCase.swift
//  
//
//  Created by Dmytro Yantsybaiev on 11.12.2023.
//

import Combine
import JADataSource
import JAInfrastructure

public final class SearchMovieUseCase: BaseUseCase<MoviePage, String> {

    private let repository: MovieRepository

    override func build(with movieName: String?) -> AnyPublisher<MoviePage, Error> {
        guard let movieName else {
            return Empty().eraseToAnyPublisher()
        }
        return repository.searchMovie(by: movieName)
    }

    public init(repository: MovieRepository) {
        self.repository = repository
        super.init()
    }
}
