//
//  DiscoverCoordinator.swift
//  CronicaClone
//
//  Created by Hakan Or on 10.05.2024.
//

import UIKit

protocol DiscoverCoordinating: Coordinator {
    func showMovieDetailView(with movie: MovieResponse.Movie)
}

class DiscoverCoordinator: DiscoverCoordinating {

    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showDiscoverViewController()
    }
    
    private func showDiscoverViewController() {
        let viewModel = DiscoverViewModel(coordinator: self)
        let viewController = DiscoverViewController(viewModel: viewModel)
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
