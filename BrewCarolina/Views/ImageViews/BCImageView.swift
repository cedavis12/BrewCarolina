//
//  BCImageView.swift
//  BrewCarolina
//
//  Created by Courtney Davis on 7/3/20.
//  Copyright © 2020 Courtney Davis. All rights reserved.
//

import UIKit

class BCImageView: UIImageView {

    let cache = NetworkManager.shared.cache
    let placeHolderImage = Images.placeholder
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 12
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        image = placeHolderImage
    }
    
    func downloadImage(fromURL url: String) {
        NetworkManager.shared.downloadImage(from: url) { [weak self] (image) in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
