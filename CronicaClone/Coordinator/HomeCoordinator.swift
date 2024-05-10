//
//  HomeCoordinator.swift
//  CronicaClone
//
//  Created by Hakan Or on 10.05.2024.
//

import UIKit

protocol HomeCoordinating: Coordinator {
    func showHomeViewController()
}

class HomeCoordinator: HomeCoordinating {

    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType = .home
    
    var finishDelegate: CoordinatorFinishDelegate?
    
    var tabBarItem: UITabBarItem
    
    private let viewFactory = ViewControllerFactory()
    
    init(_ navigationController: UINavigationController, tabBarItem: UITabBarItem) {
        self.navigationController = navigationController
        self.tabBarItem = tabBarItem
    }
    
    func start() {
        showHomeViewController()
    }
    
    func showHomeViewController() {
        let vc = viewFactory.viewController(coordinatorType: .home, self)
        navigationController.pushViewController(vc, animated: true)
    }
}
