//
//  TabBarItemFactory.swift
//  CronicaClone
//
//  Created by Hakan Or on 11.05.2024.
//

import UIKit

enum TabBarItemFactory {
    static func createTabbarItem(screenType: ScreenType) -> UITabBarItem {
        switch screenType {
        case .home:
            UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage:  UIImage(systemName: "house.fill"))
        case .discover:
            UITabBarItem(title: "Discover", image: UIImage(systemName: "popcorn"), selectedImage:  UIImage(systemName: "popcorn.fill"))
        case .watchlist:
            UITabBarItem(title: "Watchlist", image: UIImage(systemName: "rectangle.on.rectangle"), selectedImage:  UIImage(systemName: "rectangle.fill.on.rectangle.fill"))
        case .search:
            UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass.circle"), selectedImage:  UIImage(systemName: "magnifyingglass.circle.fill"))
        default:
            UITabBarItem()
        }
    }
}
