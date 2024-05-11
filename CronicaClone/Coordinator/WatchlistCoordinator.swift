//
//  WatchlistCoordinator.swift
//  CronicaClone
//
//  Created by Hakan Or on 10.05.2024.
//

import UIKit

protocol WatchlistCoordinating: Coordinator {
      func didFinish()
}

class WatchlistCoordinator: WatchlistCoordinating {

    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showWatchlistViewController()
    }
    
    private func showWatchlistViewController() {
        let viewModel = WatchlistViewModel(coordinator: self)
        let viewController = WatchlistViewController(viewModel: viewModel)
        navigationController.viewControllers.append(viewController)
    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }

    deinit {
        print(#fileID + " deinit")
    }
}
