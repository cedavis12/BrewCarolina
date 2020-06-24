//
//  SearchViewController.swift
//  BrewCarolina
//
//  Created by Courtney Davis on 6/20/20.
//  Copyright © 2020 Courtney Davis. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController{
    
    enum Section { case main }
    
    var breweries: [Brewery] = []
    var page: Int = 1
    
    var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavBar(withTitle: "Search")
        configureCollectionView()
        configureSearchController()
        getBreweries()
        
    }
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for a brewery"
        navigationItem.searchController = searchController
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createSingleColumnLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.reuseID)
    }
        
    func getBreweries() {
          NetworkManager.shared.getBreweries(page: 1) { [weak self] (breweries, errorMessage) in
              guard let self = self else { return }
              guard let breweries = breweries else {
                  print(errorMessage ?? "error")
                  return
              }
              
              self.breweries.append(contentsOf: breweries)
          }
      }
}

// MARK: UISearchResultsUpdater
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print("searching")
    }
}

// MARK: UICollectionViewDataSource
extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Breweries count \(self.breweries.count)")
        return self.breweries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.reuseID, for: indexPath) as! SearchCollectionViewCell
        let brewery = self.breweries[indexPath.row]
//        cell.backgroundColor = .systemGray5
        cell.breweryTitleLabel.text = brewery.name
        cell.breweryTypeLabel.text = "Brewery Type: \(brewery.breweryType.capitalizingFirstLetter())"
        cell.breweryLocationLabel.text = "\(brewery.city), SC"
        cell.backgroundColor = .secondarySystemBackground
        cell.layer.cornerRadius = 8
        return cell
    }
    
    
}

// MARK: UICollectionViewDelegate
//extension SearchViewController: UICollectionViewDelegate {
//
//}
