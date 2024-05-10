//
//  SearchCoordinator.swift
//  CronicaClone
//
//  Created by Hakan Or on 10.05.2024.
//

import UIKit

protocol SearchCoordinating: Coordinator {
    func showSearchViewController()
}

class SearchCoordinator: SearchCoordinating {

    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType = .search
    
    var finishDelegate: CoordinatorFinishDelegate?
    
    var tabBarItem: UITabBarItem
    
    private let viewFactory = ViewControllerFactory()
    
    init(_ navigationController: UINavigationController, tabBarItem: UITabBarItem) {
        self.navigationController = navigationController
        self.tabBarItem = tabBarItem
    }
    
    func start() {
        showSearchViewController()
    }
    
    func showSearchViewController() {
        let vc = viewFactory.viewController(coordinatorType: .search, self)
        navigationController.pushViewController(vc, animated: true)
    }
}
