//
//  WatchlistCoordinator.swift
//  CronicaClone
//
//  Created by Hakan Or on 10.05.2024.
//

import UIKit

protocol WatchlistCoordinating: Coordinator {
      
}

class WatchlistCoordinator: WatchlistCoordinating {

    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showWatchlistViewController()
    }
    
    private func showWatchlistViewController() {
        let watchlistCoordinator = WatchlistCoordinator(UINavigationController())
        self.childCoordinators.append(watchlistCoordinator)
        let viewModel = WatchlistViewModel(coordinator: watchlistCoordinator)
        let viewController = WatchlistViewController(viewModel: viewModel)
        viewController.tabBarItem = TabBarItemFactory.createTabbarItem(screenType: .watchlist)
        navigationController.pushViewController(viewController, animated: true)
    }
}
