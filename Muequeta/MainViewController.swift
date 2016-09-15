//
//  MainViewController.swift
//  Muequeta
//
//  Created by Meili Vanegas Hernández on 9/14/16.
//  Copyright © 2016 Meili Vanegas Hernández. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    
    @IBOutlet weak var logotipo: UIButton!
    var lugares = [Lugar]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        lugares = MuequetaSingleton.sharedInstance.lugares
        
        do {
            let json = NSDataAsset(name: "lugares")!.data
            if let data = try NSJSONSerialization.JSONObjectWithData(json, options:[]) as? NSDictionary {
                if let lugaresDict = data["lugares"] as? [NSDictionary] {
                    for info in lugaresDict {
                        let nom = info["nombre"] as! String
                        let desc = info["descripcion"] as! String
                        let lugar = Lugar(nombre: nom, descripcion: desc, id: MuequetaSingleton.sharedInstance.darIdLugarNuevo())
                        MuequetaSingleton.sharedInstance.agregarLugar(lugar)
                    }
                }
            }
        }
        catch {
            print("Error: \(error)" + ": Cargando la información de lugares.json")
        }
        
        for lugar in lugares {
            print(String(lugar.id) + " " + lugar.nombre)
        }

    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
}