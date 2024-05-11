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
    var parentCoordinator: Coordinator? { get set }
    
    func start()
}

extension Coordinator {
    func childDidFinish(_ coordinator : Coordinator){
        // Call this if a coordinator is done.
        for (index, child) in childCoordinators.enumerated() {
            if child === coordinator {
                print("\(child)" + " removed")
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
