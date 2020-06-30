//
//  NearbyBrewViewController.swift
//  BrewCarolina
//
//  Created by Courtney Davis on 6/20/20.
//  Copyright © 2020 Courtney Davis. All rights reserved.
//

import UIKit

class NearbyViewController: UIViewController {
    
    let titleLabel = UILabel()
    let subTitleLabel = UILabel()
    
    var venues: [Venue] = []
    var distance: Int = 25
    let items = ["25 miles", "50 miles", "100 miles"]
    
    var segmentControl: UISegmentedControl!
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavBar(withTitle: "Nearby")
        getVenues()
        configureCollectionView()
        configureUI()
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
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.view.bringSubviewToFront(self.collectionView)
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
        collectionView.register(BreweryListCell.self, forCellWithReuseIdentifier: BreweryListCell.reuseID)
    }
    
    func configureSegmentedControl() {
        segmentControl = UISegmentedControl(items: items)
        segmentControl.frame = CGRect(x: 35, y: 200, width: 250, height: 50)
        segmentControl.addTarget(self, action: #selector(segmentAction(_:)), for: .valueChanged)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func configureUI() {
        configureSegmentedControl()
//        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        titleLabel.text = "Breweries \(distance) miles near"
        titleLabel.textColor = .secondaryLabel
        titleLabel.textAlignment = .left
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        subTitleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        subTitleLabel.text = "Your location"
        subTitleLabel.textColor = .systemOrange
        subTitleLabel.textAlignment = .left
        subTitleLabel.adjustsFontSizeToFitWidth = true
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubviews(titleLabel, subTitleLabel, segmentControl)
        
        let padding: CGFloat = 15
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            subTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            subTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            segmentControl.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 15),
            segmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            collectionView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 25),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 550)
        ])
    }
    
    @objc func segmentAction(_ segmentedControl: UISegmentedControl) {
        switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            distance = 25
            titleLabel.text = "Breweries \(distance) miles near"
            break
        case 1:
            distance = 50
            titleLabel.text = "Breweries \(distance) miles near"
            break
        case 2:
            distance = 100
            titleLabel.text = "Breweries \(distance) miles near"
            break
        default:
            break
        }
    }
}

// CollectionView Delegates and Datasource
extension NearbyViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Venues count \(self.venues.count)")
        return self.venues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BreweryListCell.reuseID, for: indexPath) as! BreweryListCell
        let brewery = self.venues[indexPath.row]
        cell.backgroundColor = .systemGray5
        cell.breweryTitleLabel.text = brewery.name
        cell.breweryDistanceLabel.text = "25 miles"
        cell.breweryLocationLabel.text = "\(brewery.city), \(brewery.state)"
        cell.backgroundColor = .secondarySystemBackground
        cell.layer.cornerRadius = 8
        return cell
    }
}
