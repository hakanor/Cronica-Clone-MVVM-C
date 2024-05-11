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
    var parentCoordinator: Coordinator?
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showDiscoverViewController()
    }
    
    private func showDiscoverViewController() {
        let viewModel = DiscoverViewModel(coordinator: self)
        let viewController = DiscoverViewController(viewModel: viewModel)
        navigationController.viewControllers.append(viewController)
    }
    
    deinit {
        print(#fileID + " deinit")
    }
}
