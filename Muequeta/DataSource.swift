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
        populateData()
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
    
    // MARK:- Populate Data from plist
    
    func populateData() {
        if let path = NSBundle.mainBundle().pathForResource("fotos", ofType: "plist") {
            if let dictArray = NSArray(contentsOfFile: path) {
                for item in dictArray {
                    if let dict = item as? NSDictionary {
                        let name = dict["name"] as! String
                        let group = dict["group"] as! String
                        
                        let foto = Foto(name: name, group: group)
                        if !groups.contains(group){
                            groups.append(group)
                        }
                        fotos.append(foto)
                    }
                }
            }
        }
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
        
        let foto = Foto(name: "SugarApple", group: "Morning")
        
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