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
    let ratingLabel = BCCalloutLabel()
    let ratingCount = BCCalloutLabel()
    let accent = UIView()
    let beerDescription = UILabel()
    
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
        print(beer)
        configureViewController()
        configureUI()
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
        beerImage.downloadImage(fromURL: beer.beer.beerLabel)
        breweryTitleLabel.text = brewery
        beerTitleLabel.text = beer.beer.beerName
        beerStyleLabel.text = beer.beer.beerStyle
        

//        if let beerAbv = beer.beer.beerAbv {
//            abvTitleLabel.text = "\(beerAbv)% \n ABV"
//        }
//
//        if let beerIbu = beer.beer.beerIbu {
//            ibuTitleLabel.text = "\(beerIbu) \n IBU"
//        }
        

    }
    
    
}
