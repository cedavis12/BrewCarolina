//
//  BeerDetailViewController.swift
//  BrewCarolina
//
//  Created by Courtney Davis on 7/4/20.
//  Copyright © 2020 Courtney Davis. All rights reserved.
//

import UIKit

class BeerDetailViewController: UIViewController {
    
    let beerImage = BCImageView(frame: .zero)
    let beerTitleLabel = BCTitleLabel()
    let breweryTitleLabel = BCTitle3Label()
    let beerStyleLabel = BCTitle3Label()
    let abvTitleLabel = BCHeadlineLabel()
    let ibuTitleLabel = BCHeadlineLabel()
    let ratingLabel = BCHeadlineLabel()
    let beerDescriptionLabel = BCTitleLabel()
    let accent = UIView()
    let beerDescription = UILabel()
    let headerStack = UIStackView()
    let labelStack = UIStackView()
    
    var beer: BeerItems!
    var brewery: String!
    
    init(beer: BeerItems, brewery: String) {
        super.init(nibName: nil, bundle: nil)
        self.beer = beer
        self.brewery = brewery
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureUI()
        layoutUI()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        self.navigationItem.title = "Beer Details"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemOrange]
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    func configureUI() {
        view.addSubviews(beerImage, headerStack, labelStack, beerDescriptionLabel, accent, beerDescription)

        headerStack.translatesAutoresizingMaskIntoConstraints = false
        headerStack.addArrangedSubview(beerTitleLabel)
        headerStack.addArrangedSubview(breweryTitleLabel)
        headerStack.addArrangedSubview(beerStyleLabel)
        headerStack.axis = .vertical
        headerStack.distribution = .fillProportionally
        headerStack.spacing = 8
        
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        labelStack.addArrangedSubview(ratingLabel)
        labelStack.addArrangedSubview(abvTitleLabel)
        labelStack.addArrangedSubview(ibuTitleLabel)
        labelStack.axis = .horizontal
        labelStack.distribution = .fillEqually

        beerImage.downloadImage(fromURL: beer.beer.beerLabel)
        beerImage.layer.cornerRadius = 8
        beerTitleLabel.text = beer.beer.beerName
        beerTitleLabel.lineBreakMode = .byTruncatingTail
        breweryTitleLabel.text = brewery
        beerStyleLabel.text = beer.beer.beerStyle
        
        beerTitleLabel.numberOfLines = 0
        beerStyleLabel.numberOfLines = 0
        breweryTitleLabel.numberOfLines = 0
        abvTitleLabel.numberOfLines = 0
        ibuTitleLabel.numberOfLines = 0
        ratingLabel.numberOfLines = 0
        beerDescription.numberOfLines = 0
        
        accent.translatesAutoresizingMaskIntoConstraints = false
        accent.backgroundColor = .systemOrange
        
        beerDescription.translatesAutoresizingMaskIntoConstraints = false
        beerDescription.text = beer.beer.beerDescription
        beerDescription.textAlignment = .center
        beerDescription.textColor = .secondaryLabel
                
        if beer.beer.beerAbv > 0.0 {
            abvTitleLabel.text = "\(beer.beer.beerAbv) \n ABV"
        } else {
            abvTitleLabel.text = "ABV data \n unavailable"
        }

        if beer.beer.beerIbu > 0 {
            ibuTitleLabel.text = "\(beer.beer.beerIbu) \n IBU"
        } else {
            ibuTitleLabel.text = "IBU data \n unavailable"
        }
        
        if beer.beer.ratingScore > 0 {
            ratingLabel.text = "\(String(format: "%.1f", beer.beer.ratingScore)) \n Rating"
        } else {
            ratingLabel.text = "Not \n Rated"
        }
        
        if beer.beer.beerDescription.isEmpty {
            beerDescriptionLabel.text = ""
        } else {
            beerDescriptionLabel.text = "Beer Description"
        }
    }
    
    func layoutUI() {
        let padding: CGFloat = 8
               
        NSLayoutConstraint.activate([
            beerImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            beerImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            beerImage.heightAnchor.constraint(equalToConstant: 130),
            beerImage.widthAnchor.constraint(equalToConstant: 130),
            
            headerStack.centerYAnchor.constraint(equalTo: beerImage.centerYAnchor, constant: -15),
            headerStack.leadingAnchor.constraint(equalTo: beerImage.trailingAnchor, constant: padding),
            headerStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            headerStack.heightAnchor.constraint(lessThanOrEqualToConstant: 175),
                        
            labelStack.topAnchor.constraint(equalTo: headerStack.bottomAnchor, constant: 45),
            labelStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            labelStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            labelStack.heightAnchor.constraint(equalToConstant: 50),
            
            beerDescriptionLabel.topAnchor.constraint(equalTo: labelStack.bottomAnchor, constant: 25),
            beerDescriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            beerDescriptionLabel.heightAnchor.constraint(equalToConstant: 30),
            
            accent.topAnchor.constraint(equalTo: beerDescriptionLabel.bottomAnchor, constant: 5),
            accent.leadingAnchor.constraint(equalTo: beerDescriptionLabel.leadingAnchor),
            accent.trailingAnchor.constraint(equalTo: beerDescriptionLabel.trailingAnchor),
            accent.heightAnchor.constraint(equalToConstant: 5),

            
            beerDescription.topAnchor.constraint(equalTo: accent.bottomAnchor, constant: padding),
            beerDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            beerDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            beerDescription.heightAnchor.constraint(lessThanOrEqualToConstant: 400)
        ])
    }
}
