//
//  SceneDelegate.swift
//  CronicaClone
//
//  Created by Hakan Or on 10.05.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: Coordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        let navigationController = UINavigationController()
        self.coordinator = AppCoordinator(navigationController)
        self.coordinator?.start()
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
}

