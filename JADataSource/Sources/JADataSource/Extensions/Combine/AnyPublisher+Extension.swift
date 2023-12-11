//
//  AnyPublisher+Extension.swift
//  
//
//  Created by Dmytro Yantsybaiev on 09.12.2023.
//

import Combine

public extension AnyPublisher {

    func trackLoading(_ valueSubject: CurrentValueSubject<Bool, Never>) -> Self {
        handleEvents(receiveOutput:  { _ in
            valueSubject.send(true)
        })
        .eraseToAnyPublisher()
    }

    func trackFinished(_ valueSubject: CurrentValueSubject<Bool, Never>) -> Self {
        handleEvents(receiveOutput: { _ in
            valueSubject.send(false)
        })
        .eraseToAnyPublisher()
    }

    func trackCompletion(_ valueSubject: CurrentValueSubject<Bool, Never>) -> Self {
        handleEvents(receiveCompletion: { _ in
            valueSubject.send(false)
        })
        .eraseToAnyPublisher()
    }
}
