//
//  Injected.swift
//  JetAppTestTask
//
//  Created by Dmytro Yantsybaiev on 09.12.2023.
//

@propertyWrapper
struct Injected<T> {

    var wrappedValue: T {
        get { value }
        set { value = newValue }
    }

    private var value: T

    init() {
        value = DependencyResolver.shared.resolve()
    }
}
