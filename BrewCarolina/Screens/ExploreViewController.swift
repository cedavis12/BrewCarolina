//
//  ExploreViewController.swift
//  BrewCarolina
//
//  Created by Courtney Davis on 7/7/20.
//  Copyright © 2020 Courtney Davis. All rights reserved.
//

import UIKit

class ExploreViewController:  DataLoadingViewController {
    
    var venues: [Venues] = []
    var venueId: String!
    var breweryId: Int!
    var breweryName: String!
    var breweryDetailVC: BreweryDetailViewController!
    
    let randomButton = BCButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavBar(withTitle: "Explore")
        getVenues()
    }
    
    func getVenues() {
        showLoadingView()
        NetworkManager.shared.getFSVenues { [weak self] (result) in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let venues):
                self.venues.append(contentsOf: venues)
                DispatchQueue.main.sync {
                    self.getRandomBrewery()
                }
                
            case .failure(let errorMessage):
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Something went wrong", message: errorMessage.rawValue, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                        NSLog("The \"OK\" alert occured.")
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    func getRandomBrewery() {
        let randomBrewery = self.venues.randomElement()
        guard let venueId = randomBrewery?.id else { return }
        guard let breweryName = randomBrewery?.name else { return }
        
        configureUI(breweryName: breweryName, venueId: venueId)
    }
    
    func configureUI(breweryName: String, venueId: String) {
        breweryDetailVC = BreweryDetailViewController(breweryName: breweryName, venueId: venueId)
        addChild(breweryDetailVC)
        view.addSubviews(breweryDetailVC.view, randomButton)
        breweryDetailVC.didMove(toParent: self)
        
        randomButton.setTitle("Check Out a Random Upstate Brewery", for: .normal)
        randomButton.addTarget(self, action: #selector(randomButtonTapped), for: .touchUpInside)
        
        layoutUI()
    }
    
    func layoutUI() {
        breweryDetailVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            randomButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            randomButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            randomButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            randomButton.heightAnchor.constraint(equalToConstant: 45),
            
            breweryDetailVC.view.topAnchor.constraint(equalTo: randomButton.bottomAnchor, constant: padding),
            breweryDetailVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            breweryDetailVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            breweryDetailVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5)
        ])
    }
    
    @objc func randomButtonTapped() {
        breweryDetailVC.willMove(toParent: nil)
        breweryDetailVC.view.removeFromSuperview()
        breweryDetailVC.removeFromParent()
        getRandomBrewery()
    }
}
