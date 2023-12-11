//
//  MoviePage.swift
//
//
//  Created by Dmytro Yantsybaiev on 09.12.2023.
//

public struct MoviePage: Codable {

    public enum CodingKeys: String, CodingKey {
        case page
        case movies = "results"
        case totalPages = "total_pages"
        case totalMovies = "total_results"
    }

    public let page: Int
    public let movies: [Movie]
    public let totalPages: Int
    public let totalMovies: Int
}
