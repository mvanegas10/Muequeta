//
//  HechosController.swift
//  Muequeta
//
//  Created by Meili Vanegas Hernández on 10/30/16.
//  Copyright © 2016 Meili Vanegas Hernández. All rights reserved.
//

import UIKit
import AVFoundation
import CoreLocation

class HechosController: UITableViewController {
    
    var hechos = [Hecho]()
    
    // MARK: Will Appear
    
    override func viewDidLoad() {
        self.hechos = MuequetaSingleton.sharedInstance.hechosSeleccionados
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
        return self.hechos.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : LugaresCell = tableView.dequeueReusableCellWithIdentifier("HechosCercanosCell", forIndexPath: indexPath) as! LugaresCell
        let row = indexPath.row
        cell.nombreLugarLabel.text = self.hechos[row].nombre
        return cell
    }
}

