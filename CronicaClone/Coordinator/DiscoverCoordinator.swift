//
//  DiscoverCoordinator.swift
//  CronicaClone
//
//  Created by Hakan Or on 10.05.2024.
//

import UIKit

protocol DiscoverCoordinating: Coordinator {
    
}

class DiscoverCoordinator: DiscoverCoordinating {

    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showDiscoverViewController()
    }
    
    private func showDiscoverViewController() {
        let viewModel = DiscoverViewModel(coordinator: self)
        let viewController = DiscoverViewController(viewModel: viewModel)
        viewController.tabBarItem = TabBarItemFactory.createTabbarItem(screenType: .discover)
        navigationController.pushViewController(viewController, animated: true)
    }
}
