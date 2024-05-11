//
//  ViewControllerFactory.swift
//  CronicaClone
//
//  Created by Hakan Or on 10.05.2024.
//

import UIKit

enum ViewControllerFactory {
    static func viewController(coordinatorType: ScreenType, _ coordinator: Coordinator) -> UIViewController {
        switch coordinatorType {
        case .home:
            let homeCoordinator = HomeCoordinator(UINavigationController())
            coordinator.childCoordinators.append(homeCoordinator)
//            coordinator.start()
            let viewModel = HomeViewModel(coordinator: homeCoordinator)
            let viewController = HomeViewController(viewModel: viewModel)
            viewController.tabBarItem = TabBarItemFactory.createTabbarItem(screenType: coordinatorType)
            return viewController
        case .discover:
            let discoverCoordinator = DiscoverCoordinator(UINavigationController())
            coordinator.childCoordinators.append(discoverCoordinator)
//            coordinator.start()
            let viewModel = DiscoverViewModel(coordinator: discoverCoordinator)
            let viewController = DiscoverViewController(viewModel: viewModel)
            viewController.tabBarItem = TabBarItemFactory.createTabbarItem(screenType: coordinatorType)
            return viewController
        case .watchlist:
            let watchlistCoordinator = WatchlistCoordinator(UINavigationController())
            coordinator.childCoordinators.append(watchlistCoordinator)
//            coordinator.start()
            let viewModel = WatchlistViewModel(coordinator: watchlistCoordinator)
            let viewController = WatchlistViewController(viewModel: viewModel)
            viewController.tabBarItem = TabBarItemFactory.createTabbarItem(screenType: coordinatorType)
            return viewController
        case .search:
            let searchCoordinator = SearchCoordinator(UINavigationController())
            coordinator.childCoordinators.append(searchCoordinator)
//            coordinator.start()
            let viewModel = SearchViewModel(coordinator: searchCoordinator)
            let viewController = SearchViewController(viewModel: viewModel)
            viewController.tabBarItem = TabBarItemFactory.createTabbarItem(screenType: coordinatorType)
            return viewController
        }
    }
}
