//
//  MoviesDataSource.swift
//  JetAppTestTask
//
//  Created by Dmytro Yantsybaiev on 09.12.2023.
//

import UIKit
import JADataSource

final class MoviesDataSource: NSObject {

    private struct Values {
        static let itemWidth: CGFloat = UIScreen.main.bounds.width - 40
        static let itemHeight: CGFloat = itemWidth * 1.6
        static let horizontalEdgeInset: CGFloat = 10
    }

    private(set) var moviesCollectionView: UICollectionView!
    private(set) var movies = [Movie]()

    func configure(with moviesCollectionView: UICollectionView) {
        self.moviesCollectionView = moviesCollectionView
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        configureCollectionView()
    }

    func update() {
        moviesCollectionView?.reloadData()
        moviesCollectionView?.layoutIfNeeded()
    }

    func update(with movies: [Movie]) {
        self.movies = movies
        update()
    }

    private func configureCollectionView() {
        moviesCollectionView.register(MovieCell.self)
        update()
    }
}

extension MoviesDataSource: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(
            width: Values.itemWidth,
            height: Values.itemHeight
        )
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        10
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        .init(top: 15, left: 0, bottom: 15, right: 0)
    }
}

extension MoviesDataSource: UICollectionViewDataSource {

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        movies.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell: MovieCell = collectionView.dequeueReusableCell(indexPath)
        if let movie = movies[safe: indexPath.row] { cell.render(movie) }
        return cell
    }
}
