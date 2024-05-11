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
    
    func start()
}

extension Coordinator {
    func finish(){
        childCoordinators.removeAll()
    }
}
