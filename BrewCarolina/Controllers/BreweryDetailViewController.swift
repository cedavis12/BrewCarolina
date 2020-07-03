//
//  BreweryDetailViewController.swift
//  BrewCarolina
//
//  Created by Courtney Davis on 7/1/20.
//  Copyright © 2020 Courtney Davis. All rights reserved.
//

import UIKit

class BreweryDetailViewController: UIViewController {
    
    var breweryName: String!
    var FSID: String!
    var breweryId: Int!
    
    var breweryHeaderVC: BreweryHeaderInfoViewController!
    
    init(breweryName: String, FSID: String) {
        super.init(nibName: nil, bundle: nil)
        self.FSID = FSID
        self.breweryName = breweryName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavBar(withTitle: "Brewery Details")
        fetchBreweryId()
    }
    
    
    func fetchBreweryId() {
        NetworkManager.shared.getUTID(for: FSID) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let breweryId):
                self.breweryId = breweryId
                self.getBreweryDetails(for: breweryId)
                
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
    
    func getBreweryDetails(for breweryId: Int) {
        NetworkManager.shared.getBreweryData(for: breweryId) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let brewery):
                DispatchQueue.main.async {
                    self.configureUIElements(with: brewery)
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
    
    func configureUIElements(with brewery: Brewery) {
        breweryHeaderVC = BreweryHeaderInfoViewController(brewery: brewery, distance: 25)
        addChild(breweryHeaderVC)
        view.addSubview(breweryHeaderVC.view)
        breweryHeaderVC.didMove(toParent: self)
        constrainBreweryHeaderVC()
    }
    
    func constrainBreweryHeaderVC() {
        breweryHeaderVC.view.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 5
        
        NSLayoutConstraint.activate([
            breweryHeaderVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            breweryHeaderVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            breweryHeaderVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            breweryHeaderVC.view.heightAnchor.constraint(equalToConstant: 200)
            
        ])
    }
}
