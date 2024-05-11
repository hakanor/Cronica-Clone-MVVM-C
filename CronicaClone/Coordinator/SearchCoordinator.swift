//
//  SearchCoordinator.swift
//  CronicaClone
//
//  Created by Hakan Or on 10.05.2024.
//

import UIKit

protocol SearchCoordinating: Coordinator {
    
}

class SearchCoordinator: SearchCoordinating {

    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showSearchViewController()
    }
    
    private func showSearchViewController() {
        let searchCoordinator = SearchCoordinator(UINavigationController())
        self.childCoordinators.append(searchCoordinator)
        let viewModel = SearchViewModel(coordinator: searchCoordinator)
        let viewController = SearchViewController(viewModel: viewModel)
        viewController.tabBarItem = TabBarItemFactory.createTabbarItem(screenType: .search)
        navigationController.pushViewController(viewController, animated: true)
    }
}
