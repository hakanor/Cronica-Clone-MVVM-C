//
//  HomeCoordinator.swift
//  CronicaClone
//
//  Created by Hakan Or on 10.05.2024.
//

import UIKit

protocol HomeCoordinating: Coordinator {
    func showMovieDetailView(with movie: String)
}

class HomeCoordinator: HomeCoordinating {

    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showHomeViewController()
    }
    
    private func showHomeViewController() {
        let viewModel = HomeViewModel(coordinator: self)
        let viewController = HomeViewController(viewModel: viewModel)
        viewController.tabBarItem = TabBarItemFactory.createTabbarItem(screenType: .home)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showMovieDetailView(with movie: String) {
        let movieDetailCoordinator = MovieDetailCoordinator(navigationController, movie: movie)
        childCoordinators.append(movieDetailCoordinator)
        movieDetailCoordinator.start()
    }
}
