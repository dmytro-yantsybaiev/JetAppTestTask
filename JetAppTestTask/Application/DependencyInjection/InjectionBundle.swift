//
//  InjectionBundle.swift
//  JetAppTestTask
//
//  Created by Dmytro Yantsybaiev on 09.12.2023.
//

final class InjectionBundle {

    static func load(_ resolver: (DependencyResolver) -> Void) {
        resolver(DependencyResolver.shared)
    }
}
