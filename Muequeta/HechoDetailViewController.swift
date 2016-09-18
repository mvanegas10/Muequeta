//
//  HechoDetailViewController.swift
//  Muequeta
//
//  Created by Meili Vanegas Hernández on 9/18/16.
//  Copyright © 2016 Meili Vanegas Hernández. All rights reserved.
//

import UIKit

class HechoDetailViewController: UIViewController {
    
    
    @IBOutlet weak var horaDiaLabel: UILabel!
    @IBOutlet weak var tituloLugarText: UINavigationItem!
    @IBOutlet weak var descripcionHechoLabel: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if (MuequetaSingleton.sharedInstance.darHechosSeleccionados().count > 0) {
            let hecho = MuequetaSingleton.sharedInstance.darHechosSeleccionados()[0]
            tituloLugarText.title = hecho.nombre
            descripcionHechoLabel.text = hecho.descripcion
            horaDiaLabel.text = "Hace no mucho tiempo, en una " + MuequetaSingleton.sharedInstance.darHoraDia() + " como esta..."
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
}

