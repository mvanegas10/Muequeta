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
    var lugarSeleccionado: Lugar?
    
    override init() {
        lugares = [Lugar]()
        super.init()
    }
    
    func agregarLugar(lugar:Lugar) {
        lugares.append(lugar)
    }
    
    func darLugarSeleccionado() -> Lugar {
        return lugarSeleccionado!
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
    
}