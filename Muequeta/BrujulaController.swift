//
//  BrujulaController.swift
//  Muequeta
//
//  Created by Meili Vanegas Hernández on 11/26/16.
//  Copyright © 2016 Meili Vanegas Hernández. All rights reserved.
//

import UIKit
import CoreLocation

class BrujulaController: UIViewController, CLLocationManagerDelegate {
    var lm:CLLocationManager!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lm = CLLocationManager()
        lm.delegate = self
        
        lm.startUpdatingHeading()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateHeading newHeading: CLHeading!) {
        let magValue = newHeading.magneticHeading
        if (magValue > 315 || magValue <= 45) {
            imageView.image = UIImage(named: "lugarChorroNorte")
        }
        else if (magValue > 45 && magValue <= 135) {
            imageView.image = UIImage(named: "lugarChorroOccidente")
        }
        else if (magValue > 135 && magValue <= 225) {
            imageView.image = UIImage(named: "lugarChorroSur")
        }
        else if (magValue > 225 && magValue <= 315) {
            imageView.image = UIImage(named: "lugarChorroOriente")
        }
    }
}
