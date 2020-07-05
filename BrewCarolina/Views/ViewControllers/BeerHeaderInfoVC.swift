//
//  BeerHeaderInfoVIew.swift
//  BrewCarolina
//
//  Created by Courtney Davis on 7/1/20.
//  Copyright © 2020 Courtney Davis. All rights reserved.
//

import UIKit

class BeerInfoView: UIView {

    
    
    var beer: BeerItems!
    var index: Int!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(beer: BeerItems) {
        self.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
//       self.addSubviews(beerImage, beerTitleLabel, breweryTitleLabel, beerStyleLabel, abvTitleLabel, ibuTitleLabel, accent, beerDescription)
        
        print("Beers from the beerinfoview \(beer)")
    }
}
