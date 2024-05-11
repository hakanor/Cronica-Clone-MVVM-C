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
    var parentCoordinator: Coordinator?

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
        let homeNavigationController = UINavigationController()
        homeNavigationController.tabBarItem = TabBarItemFactory.createTabbarItem(screenType: .home)
        let homeCoordinator = HomeCoordinator(homeNavigationController)

        let discoverNavigationController = UINavigationController()
        discoverNavigationController.tabBarItem = TabBarItemFactory.createTabbarItem(screenType: .discover)
        let discoverCoordinator = DiscoverCoordinator(discoverNavigationController)

        let watchlistNavigationController = UINavigationController()
        watchlistNavigationController.tabBarItem = TabBarItemFactory.createTabbarItem(screenType: .watchlist)
        let watchlistCoordinator = WatchlistCoordinator(watchlistNavigationController)

        let searchNavigationController = UINavigationController()
        searchNavigationController.tabBarItem = TabBarItemFactory.createTabbarItem(screenType: .search)
        let searchCoordinator = SearchCoordinator(searchNavigationController)

        let tabbarCoordinators: [Coordinator] = [homeCoordinator, discoverCoordinator, watchlistCoordinator, searchCoordinator]
        tabbarCoordinators.forEach { (coordinator: Coordinator) in
            // start coordinators
            coordinator.start()
            // append coordinators to parent coordinator
            childCoordinators.append(coordinator)
        }
        
        // set tabBarController's viewControllers
        tabBarController.viewControllers = [homeNavigationController, discoverNavigationController, watchlistNavigationController, searchNavigationController]
        
        tabBarController.tabBar.backgroundColor = .systemBackground
        navigationController.pushViewController(tabBarController, animated: true)
        navigationController.setNavigationBarHidden(true, animated: true)
    }
    
    deinit {
        print(#fileID + " deinit")
    }
}
