//
//  Foto.swift
//  Muequeta
//
//  Created by Meili Vanegas Hernández on 9/17/16.
//  Copyright © 2016 Meili Vanegas Hernández. All rights reserved.
//

import Foundation

class Foto: NSObject {
    
    var name: String
    var group: String
    var descripcion: String
    
    init(name: String, group: String, descripcion: String) {
        self.name = name
        self.group = group
        self.descripcion = descripcion
        super.init()
    }
}