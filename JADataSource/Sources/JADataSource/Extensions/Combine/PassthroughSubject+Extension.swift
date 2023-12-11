//
//  PassthroughSubject+Extension.swift
//
//
//  Created by Dmytro Yantsybaiev on 09.12.2023.
//

import Combine

public extension PassthroughSubject where Output == Void {

    func send() {
        send(Void())
    }
}

