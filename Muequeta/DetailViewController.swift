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
    
    var foto: Foto?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let foto = foto {
            navigationItem.title = foto.name
            imageView.image = UIImage(named: foto.name)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}