//
//  NearbyBrewViewController.swift
//  BrewCarolina
//
//  Created by Courtney Davis on 6/20/20.
//  Copyright © 2020 Courtney Davis. All rights reserved.
//

import UIKit


class NearbyViewController: UIViewController {
    
    var venues: [Venue] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavBar(withTitle: "Nearby")
        getVenues()
    }
    
    func getVenues() {
        NetworkManager.shared.getFSVenues { [weak self] (venues, errorMessage) in
            guard let self = self else { return }
            
            guard let venues = venues else {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Something went wrong", message: errorMessage, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                        NSLog("The \"OK\" alert occured.")
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
                return
            }
            
            self.venues.append(contentsOf: venues)
        }
    }
}





