//
//  Coordinator.swift
//  CronicaClone
//
//  Created by Hakan Or on 10.05.2024.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    var type: CoordinatorType { get set }
    var finishDelegate: CoordinatorFinishDelegate? { get set } // notifiy parent
    
    func start()
}

extension Coordinator {
    func finish(){
        childCoordinators.removeAll()
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
}

enum CoordinatorType {
    case app, home, discover, watchlist, search
}

protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDidFinish(childCoordinator: Coordinator)
}
