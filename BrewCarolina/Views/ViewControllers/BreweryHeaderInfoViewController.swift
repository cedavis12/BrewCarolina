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
    let breweryImage = UIImageView()
    let locationLabel = BCTitle3Label()
    let distanceLabel = BCTitle3Label()
    
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
        view.addSubviews(breweryTitleLabel, breweryImage,  locationLabel,  distanceLabel )
        configureUIElements()
        layoutUI()
    }
    
    func configureUIElements() {
        breweryImage.image = Images.placeholder
        breweryImage.contentMode = .scaleAspectFit
        breweryImage.layer.cornerRadius = 12
        
        breweryTitleLabel.text = brewery.venueName
        breweryTitleLabel.numberOfLines = 0

        locationLabel.text = "\(brewery.location.venueAddress) \n \(brewery.location.venueCity), \(brewery.location.venueState)"
        locationLabel.numberOfLines = 0
        
        guard let distance = distance else { return }
        distanceLabel.text = "\(distance) miles"
        
    }
    
    func layoutUI() {
        breweryImage.translatesAutoresizingMaskIntoConstraints = false

        let padding: CGFloat = 10
        let imagePadding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            
            breweryImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            breweryImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            breweryImage.heightAnchor.constraint(equalToConstant: 200),
            breweryImage.widthAnchor.constraint(equalToConstant: 190),
            
            breweryTitleLabel.topAnchor.constraint(equalTo: breweryImage.topAnchor),
            breweryTitleLabel.leadingAnchor.constraint(equalTo: breweryImage.trailingAnchor),
            breweryTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            breweryTitleLabel.heightAnchor.constraint(equalToConstant: 100),
            
            locationLabel.topAnchor.constraint(equalTo: breweryTitleLabel.bottomAnchor, constant: padding),
            locationLabel.leadingAnchor.constraint(equalTo: breweryImage.trailingAnchor, constant: imagePadding),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            locationLabel.heightAnchor.constraint(equalToConstant: 50),
            
            distanceLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: padding),
            distanceLabel.leadingAnchor.constraint(equalTo: breweryImage.trailingAnchor, constant: imagePadding),
            distanceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            distanceLabel.heightAnchor.constraint(equalToConstant: 25),

        ])
    }
}
