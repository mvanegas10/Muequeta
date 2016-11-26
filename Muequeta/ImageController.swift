//
//  ImageController.swift
//  Muequeta
//
//  Created by Meili Vanegas Hernández on 10/30/16.
//  Copyright © 2016 Meili Vanegas Hernández. All rights reserved.
//

import UIKit

class ImageController: UIViewController{
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imagenView: UIImageView!
    
    @IBOutlet weak var text: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize.height = 600
        imagenView.contentMode = UIViewContentMode.ScaleAspectFit
        imagenView.clipsToBounds = true;
        imagenView.image = UIImage(named: MuequetaSingleton.sharedInstance.darImagenSeleccionada().name)
        text.text = MuequetaSingleton.sharedInstance.darImagenSeleccionada().descripcion
        text.textAlignment =  NSTextAlignment.Justified
    }
}

