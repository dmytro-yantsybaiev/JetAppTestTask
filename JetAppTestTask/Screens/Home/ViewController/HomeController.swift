//
//  HomeController.swift
//  JetAppTestTask
//
//  Created by Dmytro Yantsybaiev on 09.12.2023.
//

import UIKit
import Combine
import JADataSource

final class HomeController: NSObject {

    @IBOutlet private(set) weak var moviesCollectionView: UICollectionView!
    @IBOutlet private(set) weak var activityIndicatorView: UIActivityIndicatorView!

    let refreshControll = UIRefreshControl()
    let dataSource = MoviesDataSource()

    func configure() {
        dataSource.configure(with: moviesCollectionView)
        moviesCollectionView.refreshControl = refreshControll
    }

    func update(_ movies: [Movie]) {
        dataSource.update(with: movies)
    }
}

