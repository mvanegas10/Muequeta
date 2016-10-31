//
//  RestController.swift
//  Muequeta
//
//  Created by Meili Vanegas Hernández on 10/28/16.
//  Copyright © 2016 Meili Vanegas Hernández. All rights reserved.
//


import UIKit
import AVFoundation
import CoreLocation

class RestController: UITableViewController {
    
    var lugaresCercanos = [Lugar]()
    
    // MARK: Will Appear
    
    override func viewDidLoad() {
        self.lugaresCercanos = MuequetaSingleton.sharedInstance.darLugaresCercanos()
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
        return self.lugaresCercanos.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : LugaresCell = tableView.dequeueReusableCellWithIdentifier("LugaresCercanosCell", forIndexPath: indexPath) as! LugaresCell
        let row = indexPath.row
        cell.nombreLugarLabel.text = self.lugaresCercanos[row].nombre
        print( self.lugaresCercanos[row].nombre)
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "verLugarCercano" {
            if let indexPath = self.tableView.indexPathForSelectedRow{
                let lugar = lugaresCercanos[indexPath.row]
                MuequetaSingleton.sharedInstance.seleccionarLugar(lugar)
//                let hour = 18
//                let min = 00
                let hour = NSCalendar.currentCalendar().component(.Hour, fromDate: NSDate())
                let min = NSCalendar.currentCalendar().component(.Minute, fromDate: NSDate())
                MuequetaSingleton.sharedInstance.seleccionarHechos(Int(String(hour) + String(min))!)
                print("El seleccionado es: " + MuequetaSingleton.sharedInstance.darLugarSeleccionado().nombre)
            }
        }
        
    }
}
    