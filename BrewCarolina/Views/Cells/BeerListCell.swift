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
    
    let beerImage = UIImageView()
    let beerTitleLabel = BCHeadlineLabel()
    let beerTypeLabel = BCCalloutLabel()
    let beerABVLabel = BCCalloutLabel()
    let ratingLabel = BCCalloutLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubviews(beerImage, beerTitleLabel, beerTypeLabel, beerABVLabel, ratingLabel)
        
        let padding: CGFloat = 10
        let imagePadding: CGFloat = 15
        
        
        NSLayoutConstraint.activate([
            beerTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            beerTitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            beerTitleLabel.heightAnchor.constraint(equalToConstant: 25),
            
            beerImage.topAnchor.constraint(equalTo: beerTitleLabel.bottomAnchor, constant: padding),
            beerImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            beerImage.heightAnchor.constraint(equalToConstant: 45),
            beerImage.widthAnchor.constraint(equalToConstant: 45),
            
            beerTypeLabel.topAnchor.constraint(equalTo: beerTitleLabel.bottomAnchor, constant: padding),
            beerTypeLabel.leadingAnchor.constraint(equalTo: beerImage.trailingAnchor, constant: imagePadding),
            beerTypeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: padding),
            beerTypeLabel.heightAnchor.constraint(equalToConstant: 18),
            
            beerABVLabel.topAnchor.constraint(equalTo: beerTypeLabel.bottomAnchor, constant: padding),
            beerABVLabel.leadingAnchor.constraint(equalTo: beerImage.trailingAnchor, constant: imagePadding),
            beerABVLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: padding),
            beerABVLabel.heightAnchor.constraint(equalToConstant: 18),
            
            ratingLabel.topAnchor.constraint(equalTo: beerABVLabel.bottomAnchor, constant: padding),
            ratingLabel.leadingAnchor.constraint(equalTo: beerImage.trailingAnchor, constant: imagePadding),
            ratingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: padding),
            ratingLabel.heightAnchor.constraint(equalToConstant: 18),
            
        ])
    }
}
