//
//  UIView+Extension.swift
//  JetAppTestTask
//
//  Created by Dmytro Yantsybaiev on 10.12.2023.
//

import UIKit

extension UIView {

    enum Corner: CaseIterable {
        case topLeft
        case bottomLeft
        case topRight
        case bottomRight

        var asCACornerMask: CACornerMask {
            switch self {
            case .topLeft:
                return .layerMinXMinYCorner
            case .bottomLeft:
                return .layerMinXMaxYCorner
            case .topRight:
                return .layerMaxXMinYCorner
            case .bottomRight:
                return .layerMaxXMaxYCorner
            }
        }
    }

    func round(corners: [Corner], withValue value: CGFloat) {
        layer.masksToBounds = true
        layer.cornerRadius = value
        var maskedCorners: CACornerMask = []
        for corner in corners { maskedCorners.insert(corner.asCACornerMask) }
        layer.maskedCorners = maskedCorners
    }
}
