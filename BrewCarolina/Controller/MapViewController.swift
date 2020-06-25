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

    var breweries: [Brewery] = []
    var filteredBreweries: [Brewery] = []
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

        let center = CLLocation(latitude: 33.836082, longitude: -81.163727)
        let radius: CLLocationDistance = 450000
        let region = MKCoordinateRegion(center: center.coordinate, latitudinalMeters: radius, longitudinalMeters: radius)
        mapView.setRegion(region, animated: true)
    }
    
    func getBreweries() {
        NetworkManager.shared.getBreweries(page: page) { [weak self] (breweries, errorMessage) in
            guard let self = self else { return }
            
            guard let breweries = breweries else {
                print(errorMessage ?? "There was an error")
                return
            }
            
            self.breweries.append(contentsOf: breweries)
            DispatchQueue.main.async {
                self.setAnnotations(with: breweries)
            }
        }
    }
    
    func setAnnotations(with breweries: [Brewery]) {
        filteredBreweries = breweries.filter {$0.latitude != nil && $0.longitude != nil}
        print(filteredBreweries.count)
        
        for brewery in filteredBreweries {
            let annotation = MKPointAnnotation()
            let lat = Double(brewery.latitude!)
            let lon = Double(brewery.longitude!)
            
            annotation.coordinate = CLLocationCoordinate2D(latitude: lat!, longitude: lon!)
            mapView.addAnnotation(annotation)
            print(brewery.name)
        }
    }
}
