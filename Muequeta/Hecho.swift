//
//  Hecho.swift
//  Muequeta
//
//  Created by Meili Vanegas Hernández on 9/18/16.
//  Copyright © 2016 Meili Vanegas Hernández. All rights reserved.
//

import UIKit

class Hecho: NSObject {
    var nombre: String
    var descripcion: String
    let idLugar: Int
    let horaInicio: Int
    let horaFinal: Int
    var fotos = [Foto]()
    var videos = [String]()
    
    init(nombre: String, descripcion: String, idLugar: Int, horaInicio: Int, horaFinal:  Int, fotos: [Foto], videos: [String]) {
        self.nombre = nombre
        self.descripcion = descripcion
        self.idLugar = idLugar
        self.horaInicio = horaInicio
        self.horaFinal = horaFinal
        self.fotos = fotos
        self.videos = videos
        super.init()
    }
}