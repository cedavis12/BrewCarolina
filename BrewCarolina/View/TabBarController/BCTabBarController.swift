//
//  BCTabBarController.swift
//  BrewCarolina
//
//  Created by Courtney Davis on 6/20/20.
//  Copyright © 2020 Courtney Davis. All rights reserved.
//

import UIKit

class BCTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemOrange
        viewControllers = [createNearbyBrewNC(), createSearchVC(), createListVC(), createFavoritesVC()]
    }
    
    func createNearbyBrewNC() -> UINavigationController {
        let nearbyBrewVC = NearbyBrewViewController()
        nearbyBrewVC.tabBarItem = UITabBarItem(title: "Nearby", image: UIImage(systemName: "location"), tag: 0)
        return UINavigationController(rootViewController: nearbyBrewVC)
    }
    
    func createSearchVC() -> UINavigationController {
        let searchVC = SearchViewController()
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        return UINavigationController(rootViewController: searchVC)
    }

    
    func createListVC() -> UINavigationController {
        let listVC = ListViewController()
        listVC.tabBarItem = UITabBarItem(title: "List", image: UIImage(systemName: "list.dash"), tag: 2)
        return UINavigationController(rootViewController: listVC)
    }

    
    func createFavoritesVC() -> UINavigationController {
        let favoritesVC = FavoritesViewController()
        favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"), tag: 3)
        return UINavigationController(rootViewController: favoritesVC)
    }

}
