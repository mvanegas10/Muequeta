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

class MapController: UIViewController, CLLocationManagerDelegate, UIGestureRecognizerDelegate{
    @IBOutlet weak var mapView: MKMapView!
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
        mapView.showsUserLocation = true
        mapView.scrollEnabled = false
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action:"handleTap:")
        gestureRecognizer.delegate = self
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    
    func handleTap(gestureReconizer: UILongPressGestureRecognizer) {
        
        let location = gestureReconizer.locationInView(mapView)
        let coord = mapView.convertPoint(location,toCoordinateFromView: mapView)
        let coordinate = CLLocation(latitude: coord.latitude, longitude: coord.longitude)
        
        for lugar in MuequetaSingleton.sharedInstance.lugares {
            var coorL = CLLocation(latitude: lugar.coordenadas.0, longitude: lugar.coordenadas.1)
            let distance = coordinate.distanceFromLocation(coorL)
            if (distance < 1000) {
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: lugar.coordenadas.0, longitude: lugar.coordenadas.1)
                annotation.title = lugar.nombre
                mapView.addAnnotation(annotation)
            }
        }
        self.performSelector(#selector(self.eliminar(_:)), withObject: NSNumber(double: 5.0), afterDelay: 5.0)
    }
    
    
    func eliminar(executionTime: NSNumber) {
        mapView.removeAnnotations(mapView.annotations)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


