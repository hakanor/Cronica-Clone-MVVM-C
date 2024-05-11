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
        // TODO: - Show main screen
        let screens: [ScreenType] = [.home, .discover, .watchlist, .search]
//        tabBarController.viewControllers = screens.map { ViewControllerFactory.viewController(coordinatorType: $0, self)}
        
        let homeCoordinator = HomeCoordinator(UINavigationController())
        homeCoordinator.start()
        childCoordinators.append(homeCoordinator)
        
        let discoverCoordinator = DiscoverCoordinator(UINavigationController())
        discoverCoordinator.start()
        childCoordinators.append(discoverCoordinator)
        
        tabBarController.viewControllers = [homeCoordinator.navigationController, discoverCoordinator.navigationController]
        
        
        tabBarController.tabBar.backgroundColor = .systemBackground
        navigationController.viewControllers = [tabBarController]
    }
}
