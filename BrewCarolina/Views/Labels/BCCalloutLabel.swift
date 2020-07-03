//
//  BCCalloutLabel.swift
//  BrewCarolina
//
//  Created by Courtney Davis on 6/22/20.
//  Copyright © 2020 Courtney Davis. All rights reserved.
//

import UIKit

class BCCalloutLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        font = UIFont.preferredFont(forTextStyle: .callout)
        textColor = .secondaryLabel
        textAlignment = .center
        adjustsFontSizeToFitWidth = false
        minimumScaleFactor = 0.75
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}
