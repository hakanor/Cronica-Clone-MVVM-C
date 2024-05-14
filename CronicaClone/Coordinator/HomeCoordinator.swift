//
//  HomeCoordinator.swift
//  CronicaClone
//
//  Created by Hakan Or on 10.05.2024.
//

import UIKit

protocol HomeCoordinating: Coordinator {
    func showMovieDetailView(with movie: MovieResponse.Movie)
}

class HomeCoordinator: HomeCoordinating {

    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showHomeViewController()
    }
    
    private func showHomeViewController() {
        let viewModel = HomeViewModel(coordinator: self)
        let viewController = HomeViewController(viewModel: viewModel)
        navigationController.viewControllers.append(viewController)
    }
    
    func showMovieDetailView(with movie: MovieResponse.Movie) {
        let movieDetailCoordinator = MovieDetailCoordinator(navigationController, movie: movie)
        movieDetailCoordinator.parentCoordinator = self
        childCoordinators.append(movieDetailCoordinator)
        movieDetailCoordinator.start()
    }
    
    deinit {
        print(#fileID + " deinit")
    }
}
