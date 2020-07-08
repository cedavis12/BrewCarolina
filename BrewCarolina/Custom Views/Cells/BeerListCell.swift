//
//  BeerListCell.swift
//  BrewCarolina
//
//  Created by Courtney Davis on 7/1/20.
//  Copyright © 2020 Courtney Davis. All rights reserved.
//

import UIKit

class BeerListCell: UICollectionViewCell {
    
    static let reuseID = "BeerCell"
    
    let beerImage = BCImageView(frame: .zero)
    let beerTitleLabel = BCHeadlineLabel()
    let beerTypeLabel = BCCalloutLabel()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubviews(beerImage, beerTitleLabel, beerTypeLabel)
        
        beerTitleLabel.numberOfLines = 0
        
        let padding: CGFloat = 8
        let imagePadding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            
            beerImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            beerImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            beerImage.heightAnchor.constraint(equalToConstant: 75),
            beerImage.widthAnchor.constraint(equalToConstant: 75),
            
            beerTitleLabel.centerYAnchor.constraint(equalTo: beerImage.centerYAnchor, constant: -20),
            beerTitleLabel.leadingAnchor.constraint(equalTo: beerImage.trailingAnchor, constant: imagePadding),
            beerTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            beerTitleLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 100),
        
            beerTypeLabel.topAnchor.constraint(equalTo: beerTitleLabel.bottomAnchor, constant: padding),
            beerTypeLabel.leadingAnchor.constraint(equalTo: beerImage.trailingAnchor, constant: imagePadding),
            beerTypeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: padding),
            beerTypeLabel.heightAnchor.constraint(equalToConstant: 18),
        ])
    }
}
