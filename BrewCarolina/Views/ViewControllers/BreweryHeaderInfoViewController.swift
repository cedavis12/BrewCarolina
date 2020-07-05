//
//  BreweryHeaderInfoViewController.swift
//  BrewCarolina
//
//  Created by Courtney Davis on 7/1/20.
//  Copyright © 2020 Courtney Davis. All rights reserved.
//

import UIKit

class BreweryHeaderInfoViewController: UIViewController {
    
    let breweryTitleLabel = BCTitleLabel()
    let breweryImage = BCImageView(frame: .zero)
    let locationLabel = BCTitle3Label()
    
    var brewery: Brewery!
    var distance: Int!
    
    init(brewery: Brewery, distance: Int) {
        super.init(nibName: nil, bundle: nil)
        self.distance = distance
        self.brewery = brewery
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(breweryTitleLabel, breweryImage,  locationLabel )
        configureUIElements()
        layoutUI()
    }
    
    func configureUIElements() {
        breweryImage.downloadImage(fromURL: brewery.venueIcon.md)
        
        breweryTitleLabel.text = brewery.venueName
        breweryTitleLabel.numberOfLines = 0
        
        locationLabel.text = "\(brewery.location.venueAddress) \n \(brewery.location.venueCity), \(brewery.location.venueState)"
        locationLabel.numberOfLines = 0
    }
    
    func layoutUI() {
        
        let padding: CGFloat = 8
        let imagePadding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            
            breweryImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            breweryImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            breweryImage.heightAnchor.constraint(equalToConstant: 100),
            breweryImage.widthAnchor.constraint(equalToConstant: 100),
            
            breweryTitleLabel.centerYAnchor.constraint(equalTo: breweryImage.centerYAnchor, constant: -15),
            breweryTitleLabel.leadingAnchor.constraint(equalTo: breweryImage.trailingAnchor, constant: 5),
            breweryTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            breweryTitleLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 100),
            
            locationLabel.topAnchor.constraint(equalTo: breweryTitleLabel.bottomAnchor, constant: padding),
            locationLabel.leadingAnchor.constraint(equalTo: breweryImage.trailingAnchor, constant: imagePadding),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            locationLabel.heightAnchor.constraint(equalToConstant: 50),
            
        ])
    }
}
