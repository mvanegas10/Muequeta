//
//  LugarDetailViewController.swift
//  Muequeta
//
//  Created by Meili Vanegas Hernández on 9/17/16.
//  Copyright © 2016 Meili Vanegas Hernández. All rights reserved.
//

import UIKit

class LugarDetailViewController: UIViewController {
    
    @IBOutlet weak var tituloLugarText: UINavigationItem!
    @IBOutlet weak var descripcionLugarLabel: UITextView!
    
    @IBAction func verVideosButton(sender: UIButton) {
        mostrarAlerta("¡Oops! No hay videos asociados a este lugar, deberías ayudarnos y agregar unos tú")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tituloLugarText.title = MuequetaSingleton.sharedInstance.darLugarSeleccionado().nombre
        descripcionLugarLabel.text = MuequetaSingleton.sharedInstance.darLugarSeleccionado().descripcion
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        if segue!.identifier == "verHechos" {
            if (MuequetaSingleton.sharedInstance.darHechosSeleccionados().count == 0) {
                mostrarAlerta("Oops, al parecer no tenemos hechos asociadas a este lugar. ¡Sé el protagonista de nuestra primera anécdota!")
            }
        }
    }
    
    func mostrarAlerta(mensaje: String){
        let alert = UIAlertController(title: "Mensaje", message: mensaje, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }


}
