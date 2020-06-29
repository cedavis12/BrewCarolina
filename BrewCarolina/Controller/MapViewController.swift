
//
//  MapViewController.swift
//  BrewCarolina
//
//  Created by Courtney Davis on 6/21/20.
//  Copyright © 2020 Courtney Davis. All rights reserved.
//
import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var venues: [Venue] = []
    var filteredVenues: [Venue] = []
    var page: Int = 1
    
    let mapView = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavBar(withTitle: "Map")
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
                self.setAnnotations(with: venues)
            }
        }
    }
    
    func setAnnotations(with venues: [Venue]) {
        for venue in venues {
            let annotation = MKPointAnnotation()
            let lat = venue.latitude
            let lon = venue.longitude
            
            annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            annotation.title = venue.name
            mapView.addAnnotation(annotation)
        }
    }
}

