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
    
    var lugares = [Lugar]()
    var ratings = [Rating]()
    var hechosSeleccionados = [Hecho]()
    var lugarSeleccionado: Lugar?
    var horaDia: String?
    var viendoHechos: Bool = false
    
    // MARK: Initialization
    
    override init() {
        lugares = [Lugar]()
        super.init()
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
    
    func agregarRating(rating:Rating) {
        ratings.append(rating)
    }
    
    func darLugarSeleccionado() -> Lugar {
        return lugarSeleccionado!
    }
    
    func darHechosSeleccionados() -> [Hecho] {
        return hechosSeleccionados
    }
    
    func darRatings() -> [Rating] {
        return ratings
    }
    
    func darRating(idLugar: Int) -> Rating {
        var encontrado: Rating!
        print(ratings.count)
        for rating in ratings {
            print(String(rating.id) + " " + String(rating.rating))
            if (idLugar == rating.id) {
                encontrado = rating
            }
        }
        return encontrado
    }
    
    func cambiarRating(idLugar: Int,rating:Int) -> Rating {
        var encontrado: Rating!
        for ratingObject in ratings {
            if (idLugar == ratingObject.id) {
                ratingObject.rating = rating
                encontrado = ratingObject
            }
        }
        return encontrado
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
            horaDia = "mañana"
        }
        else if (hora <= 1900) {
            horaDia = "tarde"
        }
        else {
            horaDia = "noche"
        }
        return hechosSeleccionados
    }
    
    // MARK: Encoding process
    
    func guardarRatings() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(ratings, toFile: Rating.ArchiveURL.path! + dia)
        if !isSuccessfulSave {
            print("Error guardando ratings")
        }
    }
    
    func cargarRatings() -> [Rating]? {
        ratings = (NSKeyedUnarchiver.unarchiveObjectWithFile(Rating.ArchiveURL.path!) as? [Rating])!
        return ratings

    }
    
}