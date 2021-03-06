//
//  LugarQRDetailController.swift
//  Muequeta
//
//  Created by Meili Vanegas Hernández on 10/30/16.
//  Copyright © 2016 Meili Vanegas Hernández. All rights reserved.
//

import UIKit

class LugarQRDetailViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var tituloLugarLabel: UILabel!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var descripcionLugarLabel: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: Actions
    
    @IBAction func verVideos(sender: UIButton) {
        mostrarAlerta("¡Oops! No hay videos asociados a este lugar, deberías ayudarnos y agregar unos tú")
    }
    
    // MARK: Did load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize.height = 600
        print("En el detalle es: " + MuequetaSingleton.sharedInstance.darLugarSeleccionado().nombre)        
        ratingControl.rating = MuequetaSingleton.sharedInstance.darLugarSeleccionado().rating.rating
        tituloLugarLabel.text = MuequetaSingleton.sharedInstance.darLugarSeleccionado().nombre
        descripcionLugarLabel.text = MuequetaSingleton.sharedInstance.darLugarSeleccionado().descripcion
        descripcionLugarLabel.textAlignment = NSTextAlignment.Justified
    }
    
    // MARK: Will appear
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: Will disappear
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: Prepare for segue
    
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        if (segue!.identifier == "verHechos") {
            if (MuequetaSingleton.sharedInstance.darHechosSeleccionados().count == 0) {
                mostrarAlerta("Oops, al parecer no tenemos hechos asociadas a este lugar. ¡Sé el protagonista de nuestra primera anécdota!")
            }
            else {
                MuequetaSingleton.sharedInstance.verHechos()
                MuequetaSingleton.sharedInstance.darLugarSeleccionado().rating.rating = ratingControl.rating
                MuequetaSingleton.sharedInstance.guardarRating(MuequetaSingleton.sharedInstance.darLugarSeleccionado())
            }
        }
        else if (segue!.identifier == "verImagenesLugar") {
            MuequetaSingleton.sharedInstance.noVerHechos()
            MuequetaSingleton.sharedInstance.darLugarSeleccionado().rating.rating = ratingControl.rating
            MuequetaSingleton.sharedInstance.guardarRating(MuequetaSingleton.sharedInstance.darLugarSeleccionado())
            let viewController:ImagesCollectionViewController = segue!.destinationViewController as! ImagesCollectionViewController
            viewController.dataSource = DataSource(fotos: MuequetaSingleton.sharedInstance.darLugarSeleccionado().fotos,groups: [MuequetaSingleton.sharedInstance.darLugarSeleccionado().nombre])
        }
    }
    
    func mostrarAlerta(mensaje: String){
        let alert = UIAlertController(title: "Mensaje", message: mensaje, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
}
