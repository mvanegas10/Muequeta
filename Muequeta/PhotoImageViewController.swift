//
//  PhotoImageViewController.swift
//  Muequeta
//
//  Created by Meili Vanegas Hernández on 9/28/16.
//  Copyright © 2016 Meili Vanegas Hernández. All rights reserved.
//

import UIKit

class FotoViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    // MARK: Properties
    @IBOutlet weak var descripcionText: UITextField!
    @IBOutlet weak var imagePicked: UIImageView!
    var imagePicker: UIImagePickerController!

    @IBAction func tomarFoto(sender: UIBarButtonItem) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            var imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func guardar(sender: UIBarButtonItem) {
        let imageData = UIImageJPEGRepresentation(imagePicked.image!, 0.6)
        let compressedJPGImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedJPGImage!, nil, nil, nil)
        
        let lugar = MuequetaSingleton.sharedInstance.darLugarSeleccionado()
        let cant = MuequetaSingleton.sharedInstance.darLugarSeleccionado().fotos.count
        
        
        let json: NSDictionary = ["nombre":"lugar" + lugar.nombre + (String(cant+1)), "descripcion": descripcionText.text!]
        
        do {
            let jsonData = try NSJSONSerialization.dataWithJSONObject(json, options: .PrettyPrinted)
            
            // create post request
            let url = NSURL(string: "http://192.168.0.24:8080/lugares/" + String(lugar.id) + "/agregarImagen")!
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
        lugar.fotos.append(Foto(name:"lugar" + lugar.nombre + (String(cant+1)),group:lugar.nombre,descripcion:descripcionText.text!))
        
        mostrarAlerta("¡Gracias por compartir! Se ha guardado la imagen en la base de datos.")
    }
    @IBAction func abrirGaleria(sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            var imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
            imagePicker.allowsEditing = true
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        imagePicked.contentMode = UIViewContentMode.ScaleAspectFit
        imagePicked.clipsToBounds = true;
        imagePicked.image = image
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    
    func mostrarAlerta(mensaje: String){
        let alert = UIAlertController(title: "Mensaje", message: mensaje, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AgregarLugarController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
}



