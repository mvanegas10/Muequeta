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
        if (magValue > 315) {
            imageView.image = UIImage(named: "lugarArquitecturaNorte")
        }
        else if (magValue > 0 && magValue <= 45) {
            imageView.image = UIImage(named: "lugarArquitecturaNorOccidente")
        }
        else if (magValue > 45 && magValue <= 135) {
            imageView.image = UIImage(named: "lugarArquitecturaOccidente")
        }
        else if (magValue > 135 && magValue <= 215) {
            imageView.image = UIImage(named: "lugarArquitecturaSur")
        }
        else if (magValue > 215 && magValue <= 260) {
            imageView.image = UIImage(named: "lugarArquitecturaSurOriente")
        }
        else if (magValue > 260 && magValue <= 305) {
            imageView.image = UIImage(named: "lugarArquitecturaOriente")
        }
        else if (magValue > 305 && magValue <= 315) {
            imageView.image = UIImage(named: "lugarArquitecturaNorOriente")
        }
    }
}
