//
//  Navigatable.swift
//  JetAppTestTask
//
//  Created by Dmytro Yantsybaiev on 09.12.2023.
//

protocol Navigatable {

    associatedtype Destination

    func navigate(to destination: Destination)
}
