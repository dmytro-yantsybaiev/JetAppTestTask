//
//  UIImageView+Extension.swift
//  JetAppTestTask
//
//  Created by Dmytro Yantsybaiev on 10.12.2023.
//

import UIKit
import JADataSource

public extension UIImageView {

    func loadImage(from url: URL) {
        let imageCache: Cache<URL, UIImage> = DependencyResolver.shared.resolve()

        if let cachedImage = imageCache.value(key: url) {
            self.image = cachedImage
            return
        }

        DispatchQueue.global().async { [weak self] in
            guard let imageData = try? Data(contentsOf: url),
                  let image = UIImage(data: imageData) else {
                return
            }
            DispatchQueue.main.async {
                imageCache.insert(image, forKey: url)
                self?.image = image
            }
        }
    }
}
