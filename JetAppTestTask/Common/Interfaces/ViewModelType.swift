//
//  ViewModelType.swift
//  JetAppTestTask
//
//  Created by Dmytro Yantsybaiev on 09.12.2023.
//

protocol ViewModelType {

    associatedtype Input
    associatedtype Output

    func transform(_ input: Input) -> Output
}
