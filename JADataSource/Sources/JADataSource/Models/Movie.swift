//
//  Movie.swift
//
//
//  Created by Dmytro Yantsybaiev on 09.12.2023.
//

import Foundation

public struct Movie: Codable {

    public enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
    }

    public let id: Int
    public let title: String
    public let overview: String
    public let voteAverage: Double
    public let posterPath: String?
}

public extension Movie {

    func posterURL(size: PosterSize) -> URL? {
        guard let posterPath else {
            return nil
        }
        return URL(string: "https://image.tmdb.org/t/p/" + size.rawValue + posterPath)
    }
}
