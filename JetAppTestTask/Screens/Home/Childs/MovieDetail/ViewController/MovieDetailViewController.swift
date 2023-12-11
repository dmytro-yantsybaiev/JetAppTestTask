//
//  MovieDetailViewController.swift
//  JetAppTestTask
//
//  Created by Dmytro Yantsybaiev on 11.12.2023.
//

import UIKit
import Combine
import JADataSource

final class MovieDetailViewController: UIViewController, Storyboardable {

    @IBOutlet private weak var overviewLabel: UILabel!

    var viewModel: MovieDetailViewModel!
    var navigator: HomeNavigator!
    var movie: Movie!

    private var cancellable = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bind()
    }

    private func configure() {
        title = movie.title
        overviewLabel.text = movie.overview
    }

    private func bind() {
        let input = MovieDetailViewModel.Input()
        let output = viewModel.transform(input)
    }
}
