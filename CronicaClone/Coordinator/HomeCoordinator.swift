//
//  HomeCoordinator.swift
//  CronicaClone
//
//  Created by Hakan Or on 10.05.2024.
//

import UIKit

protocol HomeCoordinating: Coordinator {
    
}

class HomeCoordinator: HomeCoordinating {

    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showHomeViewController()
    }
    
    private func showHomeViewController() {
        let homeCoordinator = HomeCoordinator(UINavigationController())
        self.childCoordinators.append(homeCoordinator)
        let viewModel = HomeViewModel(coordinator: self)
        let viewController = HomeViewController(viewModel: viewModel)
        viewController.tabBarItem = TabBarItemFactory.createTabbarItem(screenType: .home)
        navigationController.pushViewController(viewController, animated: true)
    }
}
