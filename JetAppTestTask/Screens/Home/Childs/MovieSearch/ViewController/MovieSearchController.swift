//
//  MovieSearchController.swift
//  JetAppTestTask
//
//  Created by Dmytro Yantsybaiev on 10.12.2023.
//

import UIKit
import JADataSource

final class MovieSearchController: NSObject {

    @IBOutlet private(set) weak var searchBar: UISearchBar!
    @IBOutlet private(set) weak var moviesCollectionView: UICollectionView!

    let dataSource = MoviesDataSource()

    func configure() {
        searchBar.delegate = self
        dataSource.configure(with: moviesCollectionView)
    }

    func update(_ movies: [Movie]) {
        dataSource.update(with: movies)
    }
}

extension MovieSearchController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        UIApplication.topViewController()?.view.endEditing(true)
    }
}
