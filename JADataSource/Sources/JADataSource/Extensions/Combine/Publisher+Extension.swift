//
//  Publisher+Extension.swift
//  
//
//  Created by Dmytro Yantsybaiev on 09.12.2023.
//

import Combine

public extension Publisher {

    func sink(result: @escaping (Result<Self.Output, Self.Failure>) -> Void) -> AnyCancellable {
        sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let failure):
                result(.failure(failure))
            default:
                break
            }
        }, receiveValue: { value in
            result(.success(value))
        })
    }
}
