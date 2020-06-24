//
//  UIHelper.swift
//  BrewCarolina
//
//  Created by Courtney Davis on 6/22/20.
//  Copyright © 2020 Courtney Davis. All rights reserved.
//

import UIKit

enum UIHelper {
    
    static func createSingleColumnLayout(in view: UIView) -> UICollectionViewFlowLayout {
        
        let width = view.bounds.width
        let padding: CGFloat = 5
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / 1
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: 120)
        
        return flowLayout
    }
    
}
