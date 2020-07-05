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
    var beers: [BeerItems] = []
    
    var breweryHeaderVC: BreweryHeaderInfoViewController!
    var collectionView: UICollectionView!
    let topBeerTitleLabel = BCTitleLabel()
    let accent = UIView()
    
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
        configureCollectionView()
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
                self.beers.append(contentsOf: brewery.topBeers.items)
                DispatchQueue.main.async {
                    self.configureUIElements(with: brewery)
                    self.collectionView.reloadData()
                    self.view.bringSubviewToFront(self.collectionView)
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
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createSingleColumnLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        collectionView.register(BeerListCell.self, forCellWithReuseIdentifier: BeerListCell.reuseID)
    }
    
    func configureUIElements(with brewery: Brewery) {
        breweryHeaderVC = BreweryHeaderInfoViewController(brewery: brewery, distance: 25)
        addChild(breweryHeaderVC)
        view.addSubviews(breweryHeaderVC.view, accent, topBeerTitleLabel)
        breweryHeaderVC.didMove(toParent: self)
        
        configureUI()
    }
    
    func configureUI() {
        topBeerTitleLabel.text = "Top Beers"
        accent.translatesAutoresizingMaskIntoConstraints = false
        accent.backgroundColor = .systemOrange
        
        breweryHeaderVC.view.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 5
        
        NSLayoutConstraint.activate([
            breweryHeaderVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            breweryHeaderVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            breweryHeaderVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            breweryHeaderVC.view.heightAnchor.constraint(lessThanOrEqualToConstant: 200),
            
            topBeerTitleLabel.topAnchor.constraint(equalTo: breweryHeaderVC.view.bottomAnchor, constant: 5),
            topBeerTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topBeerTitleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            accent.topAnchor.constraint(equalTo: topBeerTitleLabel.bottomAnchor, constant: 5),
            accent.leadingAnchor.constraint(equalTo: topBeerTitleLabel.leadingAnchor),
            accent.trailingAnchor.constraint(equalTo: topBeerTitleLabel.trailingAnchor),
            accent.heightAnchor.constraint(equalToConstant: 5),
            
            collectionView.topAnchor.constraint(equalTo: accent.bottomAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15)
            
        ])
    }
}

// MARK: CollectionViewDelegate

extension BreweryDetailViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.beers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BeerListCell.reuseID, for: indexPath) as! BeerListCell
        let beer = self.beers[indexPath.row]
        
        
        cell.backgroundColor = .secondarySystemBackground
        cell.layer.cornerRadius = 8
        cell.beerImage.downloadImage(fromURL: beer.beer.beerLabel)
        cell.beerTitleLabel.text = beer.beer.beerName
        cell.beerTypeLabel.text = beer.beer.beerStyle
        
        if beer.beer.beerAbv > 0.0 {
            cell.beerABVLabel.text = "ABV: \(String(beer.beer.beerAbv))"
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let beer = self.beers[indexPath.row]
        
        let destVC = BeerDetailViewController(beer: beer, brewery: breweryName)
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }

    
    
    
}
