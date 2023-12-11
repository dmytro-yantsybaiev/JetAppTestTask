//
//  TopRatedMoviesUseCase.swift
//  JetAppTestTask
//
//  Created by Dmytro Yantsybaiev on 09.12.2023.
//

import Combine
import JADataSource
import JAInfrastructure

public final class TopRatedMoviesUseCase: BaseUseCase<MoviePage, Void> {

    private let repository: MovieRepository

    override func build(with parameters: Void? = nil) -> AnyPublisher<MoviePage, Error> {
        repository.fetchTopRatedMoviesPage()
    }

    public init(repository: MovieRepository) {
        self.repository = repository
        super.init()
    }
}
