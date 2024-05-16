//
//  DetailCoordinator.swift
//  CronicaClone
//
//  Created by Hakan Or on 11.05.2024.
//

import UIKit

protocol MovieDetailCoordinating: Coordinator {
    func didFinish()
}

final class MovieDetailCoordinator: MovieDetailCoordinating {
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    
    var movie: MovieResponse.Movie

    init(_ navigationController: UINavigationController, movie: MovieResponse.Movie) {
        self.navigationController = navigationController
        self.movie = movie
    }

    func start() {
        showMovieDetailViewController(with: movie)
    }

    private func showMovieDetailViewController(with movie: MovieResponse.Movie) {
        let viewModel = MovieDetailViewModel(coordinator: self)
        let viewController = MovieDetailViewController(viewModel: viewModel)
        viewModel.movie = movie
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
    
    deinit {
        print(#fileID + " deinit")
    }
}
