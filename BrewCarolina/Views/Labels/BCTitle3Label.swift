//
//  BCTitle3Label.swift
//  BrewCarolina
//
//  Created by Courtney Davis on 7/2/20.
//  Copyright © 2020 Courtney Davis. All rights reserved.
//

import UIKit

class BCTitle3Label: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        font = UIFont.preferredFont(forTextStyle: .title3)
        textColor = .secondaryLabel
        textAlignment = .center
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
}
