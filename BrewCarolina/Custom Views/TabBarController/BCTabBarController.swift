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
        viewControllers = [createMapNC(), createExploreVC(), createSearchVC()]
    }
    
    func createMapNC() -> UINavigationController {
           let mapVC = MapViewController()
           mapVC.tabBarItem = UITabBarItem(title: "Map", image: UIImage(systemName: "map"), tag: 0)
           return UINavigationController(rootViewController: mapVC)
       }
    

    func createExploreVC() -> UINavigationController {
        let exploreVC = ExploreViewController()
        exploreVC.tabBarItem = UITabBarItem(title: "Explore", image: UIImage(systemName: "shuffle"), tag: 1)
        return UINavigationController(rootViewController: exploreVC)
    }

    func createSearchVC() -> UINavigationController {
        let searchVC = SearchViewController()
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        return UINavigationController(rootViewController: searchVC)
    }
}
