//
//  MainViewController.swift
//  Muequeta
//
//  Created by Meili Vanegas Hernández on 9/14/16.
//  Copyright © 2016 Meili Vanegas Hernández. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var logotipo: UIButton!
    @IBOutlet weak var verNuevoLugarButton: UIButton!
    
    // MARK: Did load
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Will Appear
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let ratings:[Rating]!
        
        
        // MARK: Use in case a new place is added
//        ratings = MuequetaSingleton.sharedInstance.cargarRatings()
        
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
                        let lugar: Lugar
//                        var encontrado:Rating!
//                        for rating in ratings! {
//                            if (rating.id == idL){
//                                encontrado = rating
//                            }
//                        }
//                        if (encontrado == nil) {
//                            encontrado = Rating(id: idL, rating: 0)
//                            MuequetaSingleton.sharedInstance.agregarRating(encontrado)
//                        }
                        
                        lugar = Lugar(nombre: nom, descripcion: desc, id: idL,fotos: fot, videos: vid,coordenadas: coorFinales)
//                        MuequetaSingleton.sharedInstance.guardarRatings()
                        MuequetaSingleton.sharedInstance.agregarLugar(lugar)
                    }
                }
            }
        }
        catch {
            print("Error: \(error)" + ": Cargando la información de lugares.json")
        }
        
        do {
            let json = NSDataAsset(name: "hechos")!.data
            if let data = try NSJSONSerialization.JSONObjectWithData(json, options:[]) as? NSDictionary {
                if let hechosDict = data["hechos"] as? [NSDictionary] {
                    for info in hechosDict {
                        let idL = info["id"] as! Int
                        let nom = info["nombre"] as! String
                        let desc = info["descripcion"] as! String
                        var horaInicioFinal = 0
                        var horaFinalFinal = 0
                        if let horas = info["horas"] as? [NSDictionary] {
                            for hora in horas {
                                var horaInicio = (hora["inicio"] as! String).componentsSeparatedByString(":")
                                horaInicioFinal = Int(horaInicio[0] + horaInicio[1])!
                                
                                var horaFinal = (hora["final"] as! String).componentsSeparatedByString(":")
                                horaFinalFinal = Int(horaFinal[0] + horaFinal[1])!
                            }
                        }
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
                        let hecho = Hecho(nombre: nom, descripcion: desc, idLugar: idL, horaInicio: horaInicioFinal, horaFinal: horaFinalFinal,fotos: fot, videos: vid)
                        let lugar = MuequetaSingleton.sharedInstance.buscarLugar(String(idL))
                        MuequetaSingleton.sharedInstance.agregarHecho(lugar,hecho:hecho)
                    }
                }
            }
        }
        catch {
            print("Error: \(error)" + ": Cargando la información de hechos.json")
        }
    }
    
    // MARK: Will disappear
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
}