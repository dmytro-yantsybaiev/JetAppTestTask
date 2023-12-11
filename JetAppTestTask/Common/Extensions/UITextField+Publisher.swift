//
//  UITextField+Publisher.swift
//  JetAppTestTask
//
//  Created by Dmytro Yantsybaiev on 10.12.2023.
//

import UIKit
import Combine

extension UITextField {

    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .map { ($0.object as? UITextField)?.text  ?? "" }
            .eraseToAnyPublisher()
    }
}
