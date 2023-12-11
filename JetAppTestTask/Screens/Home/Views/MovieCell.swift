//
//  MovieCell.swift
//  JetAppTestTask
//
//  Created by Dmytro Yantsybaiev on 09.12.2023.
//

import UIKit
import JADataSource

final class MovieCell: UICollectionViewCell, TypeIdentifiable {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var ratingView: MovieRatingView!

    @IBOutlet private weak var imageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet private weak var imageViewHeightConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = nil
    }

    func render(_ movie: Movie) {
        titleLabel.text = movie.title
        ratingView.isHidden = false
        ratingView.render(rating: movie.voteAverage)

        if let posterURL = movie.posterURL(size: .w500) {
            imageView.loadImage(from: posterURL)
        }
    }

    private func configure() {
        let imageWidth = UIScreen.main.bounds.width - 40
        let imageHeight = imageWidth * 1.4
        contentView.backgroundColor = .clear
        layer.masksToBounds = false
        containerView.layer.cornerRadius = 20
        imageView.round(corners: [.topLeft, .topRight], withValue: 20)
        imageView.contentMode = .scaleAspectFill
        imageViewWidthConstraint.constant = imageWidth
        imageViewHeightConstraint.constant = imageHeight
    }
}
