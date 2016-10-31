//
//  HechoDetailViewController.swift
//  Muequeta
//
//  Created by Meili Vanegas Hernández on 9/18/16.
//  Copyright © 2016 Meili Vanegas Hernández. All rights reserved.
//

import UIKit

class HechoController: UIViewController {
    
    
    // MARK: Did load
    
    @IBAction func videos(sender: UIButton) {
        mostrarAlerta("¡Oops! No hay videos asociados a este lugar, deberías ayudarnos y agregar unos tú")
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tituloLugarText: UILabel!
    @IBOutlet weak var descripcionHechoLabel: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize.height = 600
        if (MuequetaSingleton.sharedInstance.darHechosSeleccionados().count > 0) {
            let hecho = MuequetaSingleton.sharedInstance.darHechosSeleccionados()[0]
            tituloLugarText.text = hecho.nombre
            descripcionHechoLabel.text = hecho.descripcion
        }
    }
    
    // MARK: Will appear
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: Will disappear
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func mostrarAlerta(mensaje: String){
        let alert = UIAlertController(title: "Mensaje", message: mensaje, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
}

