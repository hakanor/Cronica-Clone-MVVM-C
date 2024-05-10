//
//  DiscoverCoordinator.swift
//  CronicaClone
//
//  Created by Hakan Or on 10.05.2024.
//

import UIKit

protocol DiscoverCoordinating: Coordinator {
    func showDiscoverViewController()
}

class DiscoverCoordinator: DiscoverCoordinating {

    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType = .discover
    
    var finishDelegate: CoordinatorFinishDelegate?
    
    var tabBarItem: UITabBarItem
    
    private let viewFactory = ViewControllerFactory()
    
    init(_ navigationController: UINavigationController, tabBarItem: UITabBarItem) {
        self.navigationController = navigationController
        self.tabBarItem = tabBarItem
    }
    
    func start() {
        showDiscoverViewController()
    }
    
    func showDiscoverViewController() {
        let vc = viewFactory.viewController(coordinatorType: .discover, self)
        navigationController.pushViewController(vc, animated: true)
    }
}
