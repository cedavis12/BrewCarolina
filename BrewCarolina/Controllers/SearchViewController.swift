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
    
    var venues: [Venues] = []
    var filteredVenues: [Venues] = []
    var isSearching = false
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Venues>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavBar(withTitle: "Search")
        
        configureCollectionView()
        configureSearchController()
        getVenues()
        configureDataSource()
    }
    
    func getVenues() {
        NetworkManager.shared.getFSVenues { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let venues):
                self.venues.append(contentsOf: venues)
                self.updateData(on: self.venues)
                
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
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Venues>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, venue) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BreweryListCell.reuseID, for: indexPath) as! BreweryListCell
            cell.backgroundColor = .systemGray5
            cell.breweryTitleLabel.text = venue.name
            cell.breweryDistanceLabel.text = venue.id
            cell.breweryLocationLabel.text = "\(venue.location.city ?? ""), \(venue.location.state ?? "")"
            cell.backgroundColor = .secondarySystemBackground
            cell.layer.cornerRadius = 8
            return cell
        })
    }
    
    func updateData(on venues: [Venues]){
        var snapshot = NSDiffableDataSourceSnapshot<Section, Venues>()
        snapshot.appendSections([.main])
        snapshot.appendItems(venues)
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }

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
        collectionView.backgroundColor = .systemBackground
        collectionView.register(BreweryListCell.self, forCellWithReuseIdentifier: BreweryListCell.reuseID)
    }
}

// MARK: UICollectionViewDelegates
extension SearchViewController: UICollectionViewDelegate {
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredVenues : venues
        let brewery = activeArray[indexPath.item]

        let breweryDetailVC = BreweryDetailViewController(breweryName: brewery.name, FSID: brewery.id)
        navigationController?.pushViewController(breweryDetailVC, animated: true)
    }
}


// MARK: UISearchResultsUpdater
extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredVenues.removeAll()
            updateData(on: venues)
            isSearching = false
            return
        }
        
        isSearching = true
        filteredVenues = venues.filter { $0.name.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredVenues)
    }
}


