//
//  HomeViewController.swift
//  JetAppTestTask
//
//  Created by Dmytro Yantsybaiev on 09.12.2023.
//

import UIKit
import Combine
import JADataSource

final class HomeViewController: UIViewController, Storyboardable {

    @IBOutlet private weak var controller: HomeController!

    var viewModel: HomeViewModel!
    var navigator: HomeNavigator!

    private let fetchTopMoviesSubject = PassthroughSubject<Void, Never>()
    private let refreshTopMoviesSubject = PassthroughSubject<Void, Never>()
    private let countCharactersOccurancePublisher = PassthroughSubject<[Movie], Never>()

    private var cancellable = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bind()
        fetchTopMoviesSubject.send()
    }

    private func configure() {
        navigationItem.addCountCharactersOccuranceButton()
        navigationItem.addSearchButtom()
        controller.configure()
    }
    
    private func bind() {
        let input = HomeViewModel.Input(
            fetchTopMoviesPublisher: fetchTopMoviesSubject.eraseToAnyPublisher(),
            refreshTopMoviesPublisher: refreshTopMoviesSubject.eraseToAnyPublisher(), 
            countCharactersOccurancePublisher: countCharactersOccurancePublisher.eraseToAnyPublisher()
        )
        let output = viewModel.transform(input)

        output
            .topMoviesPublisher
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] result in
                processTopMovies(result)
            }
            .store(in: &cancellable)

        output
            .refreshedTopMoviesPublisher
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] result in
                processTopMovies(result)
                controller.refreshControll.endRefreshing()
            }
            .store(in: &cancellable)

        output
            .isLoadingPublisher
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] result in
                processIsLoading(result)
            }
            .store(in: &cancellable)

        output
            .charactersOccurancePublisher
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] result in
                processCharactersOccurance(result)
            }
            .store(in: &cancellable)

        navigationItem
            .leftBarButtonItem?
            .publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [unowned self] _ in
                countCharactersOccurancePublisher.send(controller.dataSource.movies)
            })
            .store(in: &cancellable)

        navigationItem
            .rightBarButtonItem?
            .publisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [unowned self] _ in
                navigator.navigate(to: .movieSearch)
            })
            .store(in: &cancellable)

        controller
            .refreshControll
            .publisher(for: .valueChanged)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [unowned self] isRefreshing in
                if controller.refreshControll.isRefreshing {
                    refreshTopMoviesSubject.send()
                }
            })
            .store(in: &cancellable)
    }

    private func processTopMovies(_ result: Result<MoviePage, Error>) {
        guard case .success(let moviePage) = result else {
            return
        }
        controller.update(moviePage.movies)
    }

    private func processIsLoading(_ result: Result<Bool, Never>) {
        guard case .success(let isLoading) = result, isLoading else {
            controller.activityIndicatorView.stopAnimating()
            return
        }
        controller.activityIndicatorView.startAnimating()
    }

    private func processCharactersOccurance(_ result: Result<[Character : Int], Never>) {
        guard case .success(let charactersOccurance) = result else {
            return
        }

        let message = charactersOccurance
            .sorted { $0.0 < $1.0 }
            .reduce("") { partialResult, characterOccurance in
                "\(partialResult)\(characterOccurance.key) – \(characterOccurance.value)\n"
            }
        let alertController = UIAlertController(title: "Characters Occurance", message: message, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Close", style: .default) { _ in
            UIApplication.topViewController()?.dismiss(animated: true)
        }

        alertController.addAction(closeAction)
        present(alertController, animated: true)
    }
}
