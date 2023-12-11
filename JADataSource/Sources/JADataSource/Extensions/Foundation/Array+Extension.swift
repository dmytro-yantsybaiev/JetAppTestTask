//
//  Array+Extension.swift
//
//
//  Created by Dmytro Yantsybaiev on 09.12.2023.
//

public extension Array {
    subscript(safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
