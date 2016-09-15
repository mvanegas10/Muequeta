//
//  Lugar.swift
//  Muequeta
//
//  Created by Meili Vanegas Hernández on 9/14/16.
//  Copyright © 2016 Meili Vanegas Hernández. All rights reserved.
//

import UIKit

class Lugar: NSObject {
    var nombre: String
    var descripcion: String
    let id: Int
    
    init(nombre: String, descripcion: String, id: Int) {
        self.nombre = nombre
        self.descripcion = descripcion
        self.id = id
        super.init()
    }
}