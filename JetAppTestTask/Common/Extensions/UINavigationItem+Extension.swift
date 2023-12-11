//
//  UINavigationItem+Extension.swift
//  JetAppTestTask
//
//  Created by Dmytro Yantsybaiev on 10.12.2023.
//

import UIKit

extension UINavigationItem {

    func addSearchButtom() {
        let button = UIBarButtonItem(
            image: UIImage(systemName: "magnifyingglass"),
            style: .plain,
            target: nil,
            action: nil
        )
        button.tintColor = .white
        rightBarButtonItem = button
    }
}
