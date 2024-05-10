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
    
    var type: CoordinatorType = .app
    
    var finishDelegate: CoordinatorFinishDelegate?
    
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
        tabBarController.viewControllers = TabBarPage.allCases.map { makeViewController(for: $0)}
        tabBarController.tabBar.backgroundColor = .systemBackground
        navigationController.viewControllers = [tabBarController]
    }
}

extension AppCoordinator {
    private func makeViewController(for tabPage: TabBarPage) -> UIViewController {
        switch tabPage {
            // TODO: - Move Coordinator to coordinator factory
        case .home:
            // Add HomeView
            let navigationController = UINavigationController()
            let coordinator = HomeCoordinator(navigationController, tabBarItem: tabPage.tabBarItem)
            coordinator.finishDelegate = self
            childCoordinators.append(coordinator)
            coordinator.start()
            return navigationController
        case .discover:
            // Add DiscoverView
            let navigationController = UINavigationController()
            let coordinator = DiscoverCoordinator(navigationController, tabBarItem: tabPage.tabBarItem)
            coordinator.finishDelegate = self
            childCoordinators.append(coordinator)
            coordinator.start()
            return navigationController
        case .watchlist:
            // Add Watchlist view
            let navigationController = UINavigationController()
            let coordinator = WatchlistCoordinator(navigationController, tabBarItem: tabPage.tabBarItem)
            coordinator.finishDelegate = self
            childCoordinators.append(coordinator)
            coordinator.start()
            return navigationController
        case .search:
            // Add SearchView
            let navigationController = UINavigationController()
            let coordinator = SearchCoordinator(navigationController, tabBarItem: tabPage.tabBarItem)
            coordinator.finishDelegate = self
            childCoordinators.append(coordinator)
            coordinator.start()
            return navigationController
        }
    }
}

extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0.type != childCoordinator.type } // remove child
        // TODO: - Do actions based on types accordingly if needed
        switch childCoordinator.type {
        case .app:
            print(childCoordinator.type)
        case .home:
            print(childCoordinator.type)
        case .discover:
            print(childCoordinator.type)
        case .watchlist:
            print(childCoordinator.type)
        case .search:
            print(childCoordinator.type)
        }
    }
}


enum TabBarPage: Int, CaseIterable {
    case home, discover, watchlist, search
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .discover:
            return "Discover"
        case .watchlist:
            return "Watchlist"
        case .search:
            return "Search"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .home:
            return UIImage(systemName: "house")
        case .discover:
            return UIImage(systemName: "popcorn")
        case .watchlist:
            return UIImage(systemName: "rectangle.on.rectangle")
        case .search:
            return UIImage(systemName: "magnifyingglass.circle")
        }
    }
    
    var selectedImage: UIImage? {
        switch self {
        case .home:
            return UIImage(systemName: "house.fill")
        case .discover:
            return UIImage(systemName: "popcorn.fill")
        case .watchlist:
            return UIImage(systemName: "rectangle.fill.on.rectangle.fill")
        case .search:
            return UIImage(systemName: "magnifyingglass.circle.fill")
        }
    }
    
    var tabBarItem: UITabBarItem {
        UITabBarItem(title: title, image: image, selectedImage: selectedImage)
    }
}
