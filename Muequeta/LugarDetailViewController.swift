//
//  LugarDetailViewController.swift
//  Muequeta
//
//  Created by Meili Vanegas Hernández on 9/17/16.
//  Copyright © 2016 Meili Vanegas Hernández. All rights reserved.
//

import UIKit

class LugarDetailViewController: UIViewController {
    
    @IBOutlet weak var nombreLugarLabel: UILabel!
    @IBOutlet weak var descripcionLugarLabel: UITextView!
    @IBOutlet weak var coleccionImagenes: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nombreLugarLabel.text = MuequetaSingleton.sharedInstance.darLugarSeleccionado().nombre
        descripcionLugarLabel.text = MuequetaSingleton.sharedInstance.darLugarSeleccionado().descripcion
//        coleccionImagenes.dataSource(MuequetaSingleton.sharedInstance.darLugarSeleccionado().fotos)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }

}
