//
//  BCButton.swift
//  BrewCarolina
//
//  Created by Courtney Davis on 7/7/20.
//  Copyright © 2020 Courtney Davis. All rights reserved.
//

import UIKit

class BCButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 8
        backgroundColor = .secondarySystemBackground
        setTitleColor(.secondaryLabel, for: .normal)
        titleLabel?.font = .boldSystemFont(ofSize: 17)
        titleLabel?.numberOfLines = 0
    }
}

