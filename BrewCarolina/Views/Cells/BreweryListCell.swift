//
//  SearchCollectionViewCell.swift
//  BrewCarolina
//
//  Created by Courtney Davis on 6/22/20.
//  Copyright © 2020 Courtney Davis. All rights reserved.
//

import UIKit

class BreweryListCell: UICollectionViewCell {
    
    static let reuseID = "SearchCell"
    
    let breweryTitleLabel = BCHeadlineLabel()
    let breweryDistanceLabel = BCCalloutLabel()
    let breweryLocationLabel = BCCalloutLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        addSubviews(breweryTitleLabel, breweryDistanceLabel, breweryLocationLabel)
        
        NSLayoutConstraint.activate([
            breweryTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            breweryTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            breweryTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            breweryTitleLabel.heightAnchor.constraint(equalToConstant: 25),
            
            breweryDistanceLabel.topAnchor.constraint(equalTo: breweryTitleLabel.bottomAnchor, constant: 12),
            breweryDistanceLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            breweryDistanceLabel.heightAnchor.constraint(equalToConstant: 18),
            
            breweryLocationLabel.topAnchor.constraint(equalTo: breweryDistanceLabel.bottomAnchor, constant: 12),
            breweryLocationLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            breweryLocationLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
}
