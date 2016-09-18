//
//  DataSource.swift
//  Muequeta
//
//  Created by Meili Vanegas Hernández on 9/17/16.
//  Copyright © 2016 Meili Vanegas Hernández. All rights reserved.
//

import Foundation

class DataSource {
    
    init() {
        fotos = MuequetaSingleton.sharedInstance.darLugarSeleccionado().fotos
        groups = [MuequetaSingleton.sharedInstance.darLugarSeleccionado().nombre]
    }
    
    var fotos:[Foto] = []
    var groups:[String] = []
    
    
    func numbeOfRowsInEachGroup(index: Int) -> Int {
        return fotosInGroup(index).count
    }
    
    func numberOfGroups() -> Int {
        return groups.count
    }
    
    func gettGroupLabelAtIndex(index: Int) -> String {
        return groups[index]
    }
    
    // MARK:- fotosForEachGroup
    
    func fotosInGroup(index: Int) -> [Foto] {
        let item = groups[index]
        let filteredfotos = fotos.filter { (Foto: Foto) -> Bool in
            return Foto.group == item
        }
        return filteredfotos
    }
    
    // MARK:- Add Dummy Data
    
    func addAndGetIndexForNewItem() -> Int {
        
        let foto = Foto(name: "palacio1", group: "Palacio de Justicia",descripcion: "Palacio de Justicia")
        
        let count = fotosInGroup(0).count
        
        let index = count > 0 ? count - 1 : count
        fotos.insert(foto, atIndex: index)
        
        return index
    }
    
    // MARK:- Delete Items
    
    func deleteItems(items: [Foto]) {
        
        for item in items {
            // remove item
            let index = fotos.indexOfObject(item)
            if index != -1 {
                fotos.removeAtIndex(index)
            }
        }
    }
}

extension Array {
    func indexOfObject<T:AnyObject>(item:T) -> Int {
        var index = -1
        for element in self {
            index = index + 1
            if item === element as? T {
                return index
            }
        }
        return index
    }
}