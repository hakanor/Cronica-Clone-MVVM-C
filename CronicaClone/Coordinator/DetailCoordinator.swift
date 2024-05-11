//
//  DetailCoordinator.swift
//  CronicaClone
//
//  Created by Hakan Or on 11.05.2024.
//

import UIKit

protocol MovieDetailCoordinating: Coordinator {
    
}

final class MovieDetailCoordinator: MovieDetailCoordinating {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var movie: String

    init(_ navigationController: UINavigationController, movie: String) {
        self.navigationController = navigationController
        self.movie = movie
    }

    func start() {
        showMovieDetailViewController(with: movie)
    }

    private func showMovieDetailViewController(with movie: String) {
        let viewModel = MovieDetailViewModel(coordinator: self)
        let viewController = MovieDetailViewController(viewModel: viewModel)
        viewModel.movie = movie
        navigationController.pushViewController(viewController, animated: true)
    }
}
