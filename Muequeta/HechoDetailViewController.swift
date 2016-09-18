//
//  HechoDetailViewController.swift
//  Muequeta
//
//  Created by Meili Vanegas Hernández on 9/18/16.
//  Copyright © 2016 Meili Vanegas Hernández. All rights reserved.
//

import UIKit

class HechoDetailViewController: UIViewController {
    
    
    @IBOutlet weak var tituloLugarText: UINavigationItem!
    @IBOutlet weak var descripcionHechoLabel: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if (MuequetaSingleton.sharedInstance.darHechosSeleccionados().count > 0) {
            let hecho = MuequetaSingleton.sharedInstance.darHechosSeleccionados()[0]
            tituloLugarText.title = hecho.nombre
            descripcionHechoLabel.text = hecho.descripcion
        }
        else {
            mostrarAlerta("Oops, al parecer no tenemos hechos asociadas a este lugar. ¡Sé el protagonista de nuestra primera anécdota!")
        }

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func mostrarAlerta(mensaje: String){
        let alert = UIAlertController(title: "Mensaje", message: mensaje, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
}

