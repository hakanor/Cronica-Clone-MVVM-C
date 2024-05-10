//
//  ViewControllerFactory.swift
//  CronicaClone
//
//  Created by Hakan Or on 10.05.2024.
//

import UIKit

class ViewControllerFactory {
    
    func viewController(coordinatorType: CoordinatorType, _ coordinator: Coordinator) -> UIViewController {
        switch coordinatorType {
        case .home:
            let coordinator = coordinator as! HomeCoordinator
            let viewModel = HomeViewModel(coordinator: coordinator)
            let viewController = HomeViewController(viewModel: viewModel)
            viewController.tabBarItem = coordinator.tabBarItem
            return viewController
        case .discover:
            let coordinator = coordinator as! DiscoverCoordinator
            let viewModel = DiscoverViewModel(coordinator: coordinator)
            let viewController = DiscoverViewController(viewModel: viewModel)
            viewController.tabBarItem = coordinator.tabBarItem
            return viewController
        case .watchlist:
            let coordinator = coordinator as! WatchlistCoordinator
            let viewModel = WatchlistViewModel(coordinator: coordinator)
            let viewController = WatchlistViewController(viewModel: viewModel)
            viewController.tabBarItem = coordinator.tabBarItem
            return viewController
        case .search:
            let coordinator = coordinator as! SearchCoordinator
            let viewModel = SearchViewModel(coordinator: coordinator)
            let viewController = SearchViewController(viewModel: viewModel)
            viewController.tabBarItem = coordinator.tabBarItem
            return viewController
        default:
            fatalError("Coordinator type not supported")
        }
    }
}
