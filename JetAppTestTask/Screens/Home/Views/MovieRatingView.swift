//
//  MovieRatingView.swift
//  JetAppTestTask
//
//  Created by Dmytro Yantsybaiev on 11.12.2023.
//

import UIKit

final class MovieRatingView: UIView {

    private let titleLable = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }

    func render(rating: Double) {
        let roundedRating = Darwin.round(rating * 10) / 10
        titleLable.text = roundedRating.description
    }

    private func configure() {
        backgroundColor = .black
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = frame.size.width / 2
        clipsToBounds = true

        titleLable.textColor = .white
        titleLable.text = "7.5"
        titleLable.textAlignment = .center
        titleLable.font = .preferredFont(forTextStyle: .title2)
        titleLable.translatesAutoresizingMaskIntoConstraints = false

        addSubview(titleLable)
        NSLayoutConstraint.activate([
            titleLable.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLable.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
