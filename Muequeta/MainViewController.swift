//
//  MainViewController.swift
//  Muequeta
//
//  Created by Meili Vanegas Hernández on 9/14/16.
//  Copyright © 2016 Meili Vanegas Hernández. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    
    @IBOutlet weak var logotipo: UIButton!
    @IBOutlet weak var verNuevoLugarButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        do {
            let json = NSDataAsset(name: "lugares")!.data
            if let data = try NSJSONSerialization.JSONObjectWithData(json, options:[]) as? NSDictionary {
                if let lugaresDict = data["lugares"] as? [NSDictionary] {
                    for info in lugaresDict {
                        let idL = info["id"] as! Int
                        let nom = info["nombre"] as! String
                        let desc = info["descripcion"] as! String
                        var coord = (info["coordenadas"] as! String).componentsSeparatedByString(",")
                        var lat:Double
                        var lon:Double
                        lat = Double(coord[0])!
                        lon = Double(coord[1])!
                        let coorFinales = (lat, lon)
                        var fot = [Foto]()
                        var vid = [String]()
                        if let imagenes = info["imagenes"] as? [NSDictionary] {
                            for imagen in imagenes {
                                let direccion = imagen["direccion"] as! String
                                let descripcion = imagen["descripcion"] as! String
                                let foto = Foto(name: direccion, group: nom,descripcion: descripcion)
                                fot.append(foto)
                            }
                        }
                        if let videos = info["videos"] as? [NSDictionary] {
                            for video in videos {
                                vid.append(video["direccion"] as! String)
                            }
                        }
                        let lugar = Lugar(nombre: nom, descripcion: desc, id: idL,fotos: fot, videos: vid,coordenadas: coorFinales)
                        MuequetaSingleton.sharedInstance.agregarLugar(lugar)
                    }
                }
            }
        }
        catch {
            print("Error: \(error)" + ": Cargando la información de lugares.json")
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
}