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
    
    var venues: [Venue] = []
    var page: Int = 1
    
    var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavBar(withTitle: "Search")
        getVenues()
        configureCollectionView()
        configureSearchController()
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
        print("Venues count \(self.venues.count)")
        return self.venues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.reuseID, for: indexPath) as! SearchCollectionViewCell
        let brewery = self.venues[indexPath.row]
        cell.backgroundColor = .systemGray5
        cell.breweryTitleLabel.text = brewery.name
        cell.breweryTypeLabel.text = brewery.id
        cell.breweryLocationLabel.text = "\(brewery.city), \(brewery.state)"
        cell.backgroundColor = .secondarySystemBackground
        cell.layer.cornerRadius = 8
        return cell
    }
    
    
}

// MARK: UICollectionViewDelegate
//extension SearchViewController: UICollectionViewDelegate {
//
//}

