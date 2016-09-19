//
//  Lugar.swift
//  Muequeta
//
//  Created by Meili Vanegas Hernández on 9/14/16.
//  Copyright © 2016 Meili Vanegas Hernández. All rights reserved.
//

import UIKit

class Lugar: NSObject {
    
    // MARK: Properties
    
    var nombre: String
    var descripcion: String
    let id: Int
    var fotos = [Foto]()
    var videos = [String]()
    let coordenadas:(Double, Double)
    var hechos = [Hecho]()
    var rating: Rating
    
    // MARK: Initialization
    
    init(nombre: String, descripcion: String, id: Int, fotos: [Foto], videos: [String], coordenadas:(Double,Double), rating:Rating) {
        self.nombre = nombre
        self.descripcion = descripcion
        self.id = id
        self.coordenadas = coordenadas
        self.fotos = fotos
        self.videos = videos
        self.rating = rating
        super.init()
    }
    
    func agregarHecho(hecho:Hecho){
        self.hechos.append(hecho)
    }
}