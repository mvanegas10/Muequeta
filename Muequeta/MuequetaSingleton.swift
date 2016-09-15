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
    var idLugarNuevo = -1
    
    override init() {
        lugares = [Lugar]()
        super.init()
    }
    
    func agregarLugar(lugar:Lugar) {
        lugares.append(lugar)
    }
    
    func darIdLugarNuevo() -> Int {
        idLugarNuevo = idLugarNuevo + 1
        return idLugarNuevo
    }
    
}