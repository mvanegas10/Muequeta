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
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.clipsToBounds = true;
        lm.startUpdatingHeading()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateHeading newHeading: CLHeading!) {
        let magValue = newHeading.magneticHeading
        if (magValue > 310 || magValue <= 50) {
            imageView.image = UIImage(named: "lugarArquitecturaOccidente")
        }
        else if (magValue > 240 && magValue <= 310) {
            imageView.image = UIImage(named: "lugarArquitecturaSur")
        }
        else if (magValue > 220 && magValue <= 240) {
            imageView.image = UIImage(named: "lugarArquitecturaSurOriente")
        }
        else if (magValue > 150 && magValue <= 220) {
            imageView.image = UIImage(named: "lugarArquitecturaOriente")
        }
        else if (magValue > 110 && magValue <= 150) {
            imageView.image = UIImage(named: "lugarArquitecturaNorOriente")
        }
        else if (magValue > 70 && magValue <= 110) {
            imageView.image = UIImage(named: "lugarArquitecturaNorte")
        }
        else if (magValue > 50 && magValue <= 70) {
            imageView.image = UIImage(named: "lugarArquitecturaNorOccidente")
        }

    }
}
