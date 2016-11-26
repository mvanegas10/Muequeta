//
//  MuequetaSingleton.swift
//  Muequeta
//
//  Created by Meili Vanegas Hernández on 9/14/16.
//  Copyright © 2016 Meili Vanegas Hernández. All rights reserved.
//

import UIKit


class MuequetaSingleton: NSObject {
    
    // MARK: Creación de Singleton
    class var sharedInstance: MuequetaSingleton {
        struct Singleton {
            static let instance = MuequetaSingleton()
        }
        return Singleton.instance
    }
    
    // MARK: Properties
    
    let URL: String = "http://192.168.0.15:8080"
    
    var lugares = [Lugar]()
    let lugaresTotales = 10
    var hechosSeleccionados = [Hecho]()
    var lugarSeleccionado: Lugar?
    var lugaresCercanos = [Lugar]()
    var imagenSeleccionada: Foto?
    var horaDia: String?
    var viendoHechos: Bool = false
    var latitud: Double?
    var longitud: Double?
    
    // MARK: Initialization
    
    override init() {
        lugares = [Lugar]()
        super.init()
    }
    
    func seleccionarImagen(nombre: Foto) {
        self.imagenSeleccionada = nombre
    }
    
    func darImagenSeleccionada() -> Foto {
        return self.imagenSeleccionada!
    }
    
    func asignarLatitud(latitud:Double) {
        self.latitud = latitud
    }
    
    func asignarLongitud(longitud:Double) {
        self.longitud = longitud
    }
    
    func darLatitud() -> Double {
        return latitud!
    }
    
    func darLongitud() -> Double {
        return longitud!
    }
    
    func estaViendoHechos() -> Bool {
        return viendoHechos
    }
    
    func verHechos() {
        viendoHechos = true
    }
    
    func noVerHechos() {
        viendoHechos = false
    }
    
    func agregarLugar(lugar:Lugar) {
        lugares.append(lugar)
    }
    
    func agregarHecho(lugar:Lugar, hecho:Hecho) {
        lugar.agregarHecho(hecho)
    }
    
    func darLugarSeleccionado() -> Lugar {
        return lugarSeleccionado!
    }
    
    func darLugaresCercanos() -> [Lugar] {
        return lugaresCercanos
    }
    
    func darHechosSeleccionados() -> [Hecho] {
        return hechosSeleccionados
    }
    
    func darHoraDia() -> String {
        return horaDia!
    }
    
    func seleccionarLugar(lugar:Lugar) {
        viendoHechos = false
        lugarSeleccionado = lugar
    }
    
    func buscarLugar(id:String) -> Lugar {
        var encontrado: Lugar!
        for lugar in lugares{
            if String(lugar.id) == id{
                encontrado = lugar
            }
        }
        return encontrado
    }
    
    func buscarLugarPorNombre(nombre:String) -> Lugar {
        var encontrado: Lugar!
        for lugar in lugares{
            if String(lugar.nombre) == nombre{
                encontrado = lugar
            }
        }
        return encontrado
    }
    
    func buscarHecho(lugar:Lugar,nombre:String) -> Hecho {
        var encontrado: Hecho!
        for hecho in lugar.hechos{
            if String(hecho.nombre) == nombre{
                encontrado = hecho
            }
        }
        return encontrado
    }
    
    func seleccionarHechos (hora:Int) -> [Hecho] {
        hechosSeleccionados = [Hecho]()
        if (lugarSeleccionado != nil) {
            for hecho in (lugarSeleccionado?.hechos)! {
                if (hecho.horaInicio <= hora && hecho.horaFinal >= hora) {
                    hechosSeleccionados.append(hecho)
                }
            }
        }
        if (hora <= 1200) {
            print("menos a 1200")
            horaDia = "mañana"
        }
        else if (hora <= 1900) {
            horaDia = "tarde"
        }
        else if (hora > 1900) {
            horaDia = "noche"
        }
        return hechosSeleccionados
    }
    
    // MARK: Encoding process
    
    func guardarRating(lugar:Lugar) {
        print("Al guardar")
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(lugar.rating, toFile: Rating.ArchiveURL.path! + "l" +  String(lugar.id))
        if !isSuccessfulSave {
            print("Error guardando ratings")
        }
        else {
            print("Se guardó el rating " + String(lugar.rating.rating) + " del lugar" + lugar.nombre + " exitosamente")
        }
    }
    
    func cargarRatings() {
        print("Al cargar")
        for i in 1...lugaresTotales {
            let path = Rating.ArchiveURL.path! + "l" +  String(i)
            let nskeyed = NSKeyedUnarchiver.self
            let rating = (nskeyed.unarchiveObjectWithFile(path) as? Rating)
            let lugar = buscarLugar(String(i))
            lugar.rating = rating!
            print("Se cargó el rating " + String(rating!.rating) + " del lugar" + lugar.nombre + " exitosamente")
        }
    }
    
    // MARK: Dar lugares cercanos
    
    func encontrarLugaresCerca(latitud: Double, longitud: Double) {
        // prepare json data
        
        let json = [ "latitud":latitud, "longitud":longitud ]
        do {
            let jsonData = try NSJSONSerialization.dataWithJSONObject(json, options: .PrettyPrinted)
            
            // create post request
            let url = NSURL(string: URL + "/lugaresCerca")!
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
                do {
                    if let responseJSON = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String:AnyObject] {
                        for lugar in (responseJSON["lugares"] as? NSArray)! {
                            let actual = lugar as? NSArray
                            let lugarActual = MuequetaSingleton.sharedInstance.buscarLugarPorNombre(actual![1] as! String)
                            self.lugaresCercanos.append(lugarActual)
                        }
                    }
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
            task.resume()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}