//
//  MovieRepository.swift
//
//
//  Created by Dmytro Yantsybaiev on 09.12.2023.
//

import Combine
import JADataSource
import JAInfrastructure

public final class MovieRepository {

    private let networkService: NetworkService
    private let movieAPI: MovieDatabaseAPI

    func fetchTopRatedMoviesPage() -> AnyPublisher<MoviePage, Error> {
        networkService.perform(movieAPI.request(type: .topRated))
    }

    func searchMovie(by name: String) -> AnyPublisher<MoviePage, Error> {
        networkService.perform(movieAPI.request(type: .searchMovie, parameters: ["query": name]))
    }

    public init() {
        networkService = NetworkService()
        movieAPI = MovieDatabaseAPI()
    }
}
