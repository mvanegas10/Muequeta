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
        var a1 = Foto(name:"alfonsoReyes",group:"1",descripcion: "Palacio de Justicia")
        var a2 = Foto(name:"palacio1",group:"1",descripcion: "Palacio de Justicia")
        var a3 = Foto(name:"palacio2",group:"1",descripcion: "Palacio de Justicia")

        fotos = [a1,a2,a3]
        groups = ["1"]
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
        
        let foto = Foto(name: "palacio1", group: "1",descripcion: "Palacio de Justicia")
        
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