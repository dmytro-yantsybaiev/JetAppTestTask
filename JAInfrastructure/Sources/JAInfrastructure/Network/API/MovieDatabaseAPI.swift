//
//  MovieDatabaseAPI.swift
//
//
//  Created by Dmytro Yantsybaiev on 09.12.2023.
//

import Foundation

public struct MovieDatabaseAPI {

    private let baseURLString: String
    private let accessTokenAuth: String

    public func request(type: RequestType, parameters: [String: String] = [:]) -> URLRequest {
        var urlComponents = URLComponents(string: baseURLString + type.path)
        urlComponents?.queryItems = parameters.map { name, value in
            URLQueryItem(name: name, value: value)
        }
        var urlRequest = URLRequest(url: urlComponents!.url!)
        urlRequest.setValue("Bearer \(accessTokenAuth)", forHTTPHeaderField: "Authorization")
        return urlRequest
    }

    public init() {
        baseURLString = "https://api.themoviedb.org/3/"
        accessTokenAuth = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NGVlNGI1NjYyNWI0ZGUxNGQ3Y2Q3NzU4ZmQ5NzM0YSIsInN1YiI6IjY1NzQxYTY1ZDQwMGYzMDEwYjA1ZjRmNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.MOR2XDaUmzx3xZYzxlMUiEHB3g8tY9UGkaKEBoBh25I"
    }
}

public extension MovieDatabaseAPI {

    enum RequestType {
        case topRated
        case searchMovie

        var path: String {
            switch self {
            case .topRated:
                "movie/top_rated"
            case .searchMovie:
                "search/movie"
            }
        }
    }
}
