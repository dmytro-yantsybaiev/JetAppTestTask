//
//  NetworkService.swift
//
//
//  Created by Dmytro Yantsybaiev on 09.12.2023.
//

import Foundation
import Combine
import JADataSource

public final class NetworkService {

    public func perform<Response: Decodable>(_ urlRequest: URLRequest) -> AnyPublisher<Response, Error> {
        URLSession.shared.dataTaskPublisher(for: urlRequest)
            .timeout(10, scheduler: DispatchQueue.main)
            .receive(on: DispatchQueue.main)
            .map(\.data)
            .decode(type: Response.self, decoder: JSONDecoder.default)
            .eraseToAnyPublisher()
    }

    public init() {}
}
