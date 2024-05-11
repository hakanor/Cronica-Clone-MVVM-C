//
//  ActorDetailCoordinator.swift
//  CronicaClone
//
//  Created by Hakan Or on 11.05.2024.
//

import UIKit

protocol ActorDetailCoordinating: Coordinator {
    func didFinish()
}

final class ActorDetailCoordinator: ActorDetailCoordinating {
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    
    var actor: String

    init(_ navigationController: UINavigationController, movie: String) {
        self.navigationController = navigationController
        self.actor = movie
    }

    func start() {
        showActorDetailViewController(with: actor)
    }

    private func showActorDetailViewController(with movie: String) {
        let viewModel = ActorDetailViewModel(coordinator: self)
        let viewController = ActorDetailViewController(viewModel: viewModel)
        viewModel.actor = movie
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
    
    deinit {
        print(#fileID + " deinit")
    }
}
