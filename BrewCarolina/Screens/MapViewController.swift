
//
//  MapViewController.swift
//  BrewCarolina
//
//  Created by Courtney Davis on 6/21/20.
//  Copyright © 2020 Courtney Davis. All rights reserved.
//
import UIKit
import MapKit

class MapViewController: DataLoadingViewController {
    
    var venues: [Venues] = []
    var filteredVenues: [Venues] = []
    var page: Int = 1
    var breweryDetailVC: BreweryDetailViewController!
    
    let mapView = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavBar(withTitle: "Map")
        mapView.delegate = self
        configureMapView()
        getBreweries()
    }
    
    func configureMapView() {
        view.addSubview(mapView)
        mapView.pinToEdges(of: view)
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isPitchEnabled = true
        
        let center = CLLocation(latitude: 34.852619, longitude: -82.394012)
        let radius: CLLocationDistance = 350000
        let region = MKCoordinateRegion(center: center.coordinate, latitudinalMeters: radius, longitudinalMeters: radius)
        mapView.setRegion(region, animated: true)
    }
    
    func getBreweries() {
        showLoadingView()
        NetworkManager.shared.getFSVenues { [weak self] (result) in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let venues):
                self.venues.append(contentsOf: venues)
                DispatchQueue.main.async {
                    self.setAnnotations(with: venues)
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
    
    func setAnnotations(with venues: [Venues]) {
        for venue in venues {
            let annotation = MKPointAnnotation()
            
            let lat = venue.location.lat ?? 0.0
            let lon = venue.location.lng ?? 0.0
            
            annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            annotation.title = venue.name
            annotation.subtitle = venue.id
            mapView.addAnnotation(annotation)
            
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        guard let breweryName = view.annotation?.title else { return }
        guard let venueId = view.annotation?.subtitle else { return }
        
        let destVC = BreweryDetailViewController(breweryName: breweryName ?? "" , venueId: venueId ?? "")
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)

    }
    
}

