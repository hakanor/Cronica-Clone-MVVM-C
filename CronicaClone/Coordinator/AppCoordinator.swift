//
//  AppCoordinator.swift
//  CronicaClone
//
//  Created by Hakan Or on 10.05.2024.
//

import UIKit

protocol AppCordinating: Coordinator {
    func showMainScreen()
}

class AppCoordinator: AppCordinating {

    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []

    private var tabBarController: UITabBarController
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = UITabBarController()
    }
    
    func start() {
        showMainScreen()
    }
    
    func showMainScreen() {
        
        // Create coordinators for tabbar
        let homeCoordinator = HomeCoordinator(navigationController)
        let discoverCoordinator = DiscoverCoordinator(navigationController)
        let watchlistCoordinator = WatchlistCoordinator(navigationController)
        let searchCoordinator = SearchCoordinator(navigationController)
        
        let tabbarCoordinators: [Coordinator] = [homeCoordinator, discoverCoordinator, watchlistCoordinator, searchCoordinator]
        tabbarCoordinators.forEach { (coordinator: Coordinator) in
            // start coordinators
            coordinator.start()
            // append coordinators to parent coordinator
            childCoordinators.append(coordinator)
        }
        
        // set tabBarController's viewControllers
        tabBarController.viewControllers = navigationController.viewControllers
        
        tabBarController.tabBar.backgroundColor = .systemBackground
        navigationController.viewControllers = [tabBarController]
    }
}
