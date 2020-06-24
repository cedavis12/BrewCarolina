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
        viewControllers = [createNearbyBrewNC(), createMapNC(), createSearchVC(), createProfileVC()]
    }
    
    func createNearbyBrewNC() -> UINavigationController {
        let nearbyBrewVC = NearbyViewController()
        nearbyBrewVC.tabBarItem = UITabBarItem(title: "Nearby", image: UIImage(systemName: "location"), tag: 0)
        return UINavigationController(rootViewController: nearbyBrewVC)
    }

    func createMapNC() -> UINavigationController {
           let mapVC = MapViewController()
           mapVC.tabBarItem = UITabBarItem(title: "Map", image: UIImage(systemName: "map"), tag: 1)
           return UINavigationController(rootViewController: mapVC)
       }
    
    func createSearchVC() -> UINavigationController {
        let searchVC = SearchViewController()
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        return UINavigationController(rootViewController: searchVC)
    }
    
    func createProfileVC() -> UINavigationController {
        let profileVC = ProfileViewController()
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 3)
        return UINavigationController(rootViewController: profileVC)
    }

}
