//
//  MuequetaSingleton.swift
//  Muequeta
//
//  Created by Meili Vanegas Hernández on 9/14/16.
//  Copyright © 2016 Meili Vanegas Hernández. All rights reserved.
//

import UIKit


class MuequetaSingleton: NSObject {
    
    //Creación de Singleton
    class var sharedInstance: MuequetaSingleton {
        struct Singleton {
            static let instance = MuequetaSingleton()
        }
        return Singleton.instance
    }
    
    var lugares = [Lugar]()
    var hechosSeleccionados = [Hecho]()
    var lugarSeleccionado: Lugar?
    var horaDia: String?
    
    override init() {
        lugares = [Lugar]()
        super.init()
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
    
    func darHechosSeleccionados() -> [Hecho] {
        return hechosSeleccionados
    }
    
    func darHoraDia() -> String {
        return horaDia!
    }
    
    func seleccionarLugar(lugar:Lugar) {
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
    
}