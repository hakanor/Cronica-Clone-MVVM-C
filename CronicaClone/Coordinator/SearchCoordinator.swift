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
    var parentCoordinator: Coordinator?
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showSearchViewController()
    }
    
    private func showSearchViewController() {
        let viewModel = SearchViewModel(coordinator: self)
        let viewController = SearchViewController(viewModel: viewModel)
        navigationController.viewControllers.append(viewController)
    }
    
    deinit {
        print(#fileID + " deinit")
    }
}
