//
//  MapController.swift
//  Muequeta
//
//  Created by Meili Vanegas Hernández on 11/25/16.
//  Copyright © 2016 Meili Vanegas Hernández. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapController: UIViewController, CLLocationManagerDelegate{
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set initial location in Honolulu
        let initialLocation = CLLocation(latitude: 4.634254, longitude: -74.0)
        let regionRadius: CLLocationDistance = 25000
        func centerMapOnLocation(location: CLLocation) {
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                      regionRadius * 2.0, regionRadius * 2.0)
            mapView.setRegion(coordinateRegion, animated: true)
        }
        centerMapOnLocation(initialLocation)
        for lugar in MuequetaSingleton.sharedInstance.lugares {
            print (lugar.coordenadas.0)
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: lugar.coordenadas.0, longitude: lugar.coordenadas.1)
            annotation.title = lugar.nombre
            mapView.addAnnotation(annotation)
        }
        
        mapView.showsUserLocation = true
        mapView.scrollEnabled = false;
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


