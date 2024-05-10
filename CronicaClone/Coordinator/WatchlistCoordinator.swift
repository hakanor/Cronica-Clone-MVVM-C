//
//  WatchlistCoordinator.swift
//  CronicaClone
//
//  Created by Hakan Or on 10.05.2024.
//

import UIKit

protocol WatchlistCoordinating: Coordinator {
    func showWatchlistViewController()
}

class WatchlistCoordinator: WatchlistCoordinating {

    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType = .watchlist
    
    var finishDelegate: CoordinatorFinishDelegate?
    
    var tabBarItem: UITabBarItem
    
    private let viewFactory = ViewControllerFactory()
    
    init(_ navigationController: UINavigationController, tabBarItem: UITabBarItem) {
        self.navigationController = navigationController
        self.tabBarItem = tabBarItem
    }
    
    func start() {
        showWatchlistViewController()
    }
    
    func showWatchlistViewController() {
        let vc = viewFactory.viewController(coordinatorType: .watchlist, self)
        navigationController.pushViewController(vc, animated: true)
    }
}
