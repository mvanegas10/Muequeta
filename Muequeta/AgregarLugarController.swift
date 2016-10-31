//
//  AgregarLugarController.swift
//  Muequeta
//
//  Created by Meili Vanegas Hernández on 10/30/16.
//  Copyright © 2016 Meili Vanegas Hernández. All rights reserved.
//

import UIKit

class AgregarLugarController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nombreText: UITextField!
    @IBOutlet weak var descripcionText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize.height = 600
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AgregarLugarController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func agregarLugar(sender: UIButton) {
        // MARK: Add place
        
        if (nombreText.text != nil && descripcionText.text != nil) {
            
            let json: NSDictionary =
            [
                "nombre":nombreText.text!,
                "descripcion":descripcionText.text!,
                "latitud": MuequetaSingleton.sharedInstance.darLatitud(),
                "longitud": MuequetaSingleton.sharedInstance.darLongitud()
            ]
            
            do {
                let jsonData = try NSJSONSerialization.dataWithJSONObject(json, options: .PrettyPrinted)
                
                // create post request
                let url = NSURL(string: MuequetaSingleton.sharedInstance.URL + "/agregarLugar")!
                let request = NSMutableURLRequest(URL: url)
                request.HTTPMethod = "POST"
                
                // insert json data to the request
                request.HTTPBody = jsonData
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let task = NSURLSession.sharedSession().dataTaskWithRequest(request){ data,response,error in
                    if error != nil{
                        print(error!.localizedDescription)
                        return
                    }
                }
                task.resume()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        mostrarAlerta("El lugar " + nombreText.text! + " se ha agregado correctamente. ¡Gracias por ayudarnos a mejorar!")
        
        
    }
    
    func mostrarAlerta(mensaje: String){
        let alert = UIAlertController(title: "Mensaje", message: mensaje, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
}
