//
//  UIViewController+Ext.swift
//  BrewCarolina
//
//  Created by Courtney Davis on 6/20/20.
//  Copyright © 2020 Courtney Davis. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func configureNavBar(withTitle title: String) {
        view.backgroundColor = .systemBackground
        self.title = title
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemOrange]
    }
    
    func configureNavBar(withLongTitle title: String) {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemOrange]
        self.title = title
        for navItem in (self.navigationController?.navigationBar.subviews)! {
            for itemSubView in navItem.subviews {
                if let largeLabel = itemSubView as? UILabel {
                    largeLabel.text = self.title
                    largeLabel.numberOfLines = 0
                    largeLabel.lineBreakMode = .byWordWrapping
                }
            }
        }
    }
}
