//
//  ImagenesController.swift
//  Muequeta
//
//  Created by Meili Vanegas Hernández on 10/30/16.
//  Copyright © 2016 Meili Vanegas Hernández. All rights reserved.
//

import UIKit
import AVFoundation

class ImagenesController: UITableViewController {
    
    var imagenes = [Foto]()
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        MuequetaSingleton.sharedInstance.seleccionarImagen(self.imagenes[indexPath.row])
    }
    
    // MARK: Will Appear
    
    override func viewDidLoad() {
        print("En las imágenes de: " + MuequetaSingleton.sharedInstance.darLugarSeleccionado().nombre)
        print(MuequetaSingleton.sharedInstance.darLugarSeleccionado().fotos)
        self.imagenes = MuequetaSingleton.sharedInstance.darLugarSeleccionado().fotos
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.imagenes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : LugaresCell = tableView.dequeueReusableCellWithIdentifier("ImagenesCell", forIndexPath: indexPath) as! LugaresCell
        let row = indexPath.row
        cell.nombreLugarLabel.text = self.imagenes[row].descripcion
        cell.imagenView.contentMode = UIViewContentMode.ScaleAspectFit
        cell.clipsToBounds = true;
        cell.imagenView.image = UIImage(named: self.imagenes[row].name)
        print( self.imagenes[row].name)
        return cell
    }
}
