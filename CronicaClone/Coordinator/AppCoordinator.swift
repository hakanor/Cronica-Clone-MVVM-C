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
        let homeCoordinator = HomeCoordinator(UINavigationController())
        let discoverCoordinator = DiscoverCoordinator(UINavigationController())
        let watchlistCoordinator = WatchlistCoordinator(UINavigationController())
        let searchCoordinator = SearchCoordinator(UINavigationController())
        
        let tabbarCoordinators: [Coordinator] = [homeCoordinator, discoverCoordinator, watchlistCoordinator, searchCoordinator]
        
        tabbarCoordinators.forEach { (coordinator: Coordinator) in
            // start coordinators
            coordinator.start()
            // append coordinators to parent coordinator
            childCoordinators.append(coordinator)
        }
        
        // append coordinator navigationController to tabbar's viewControllers
        tabBarController.viewControllers = tabbarCoordinators.map { $0.navigationController }
        
        //tabbar customization
        tabBarController.tabBar.backgroundColor = .systemBackground
        navigationController.viewControllers = [tabBarController]
    }
}
