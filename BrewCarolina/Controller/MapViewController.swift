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

    let mapView = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavBar(withTitle: "Map")
        configureMapView()
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
}
