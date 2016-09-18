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
    var fotos = [String]()
    var videos = [String]()
    let coordenadas:(Double, Double)
    
    init(nombre: String, descripcion: String, id: Int, fotos: [String], videos: [String], coordenadas:(Double,Double)) {
        self.nombre = nombre
        self.descripcion = descripcion
        self.id = id
        self.coordenadas = coordenadas
        self.fotos = fotos
        self.videos = videos
        super.init()
    }
}