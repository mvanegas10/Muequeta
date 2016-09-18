//
//  DetailViewController.swift
//  Muequeta
//
//  Created by Meili Vanegas Hernández on 9/17/16.
//  Copyright © 2016 Meili Vanegas Hernández. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tituloLabel: UINavigationItem!
    @IBOutlet weak var descripcionTextView: UITextView!
    
    
    var foto: Foto?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let foto = foto {
            descripcionTextView.text = foto.descripcion
            imageView.image = UIImage(named: foto.name)
            tituloLabel.title = foto.group
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}