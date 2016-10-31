//
//  MainViewController.swift
//  Muequeta
//
//  Created by Meili Vanegas Hernández on 9/14/16.
//  Copyright © 2016 Meili Vanegas Hernández. All rights reserved.
//

import UIKit
import CoreLocation
class MainViewController: UIViewController, CLLocationManagerDelegate{
    
    // MARK: Properties
    
    @IBOutlet weak var logotipo: UIButton!
    @IBOutlet weak var verNuevoLugarButton: UIButton!
    var locationManager: CLLocationManager!
    
    // MARK: Did load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        var currentLocation: CLLocation?
        if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedAlways){
            currentLocation = locationManager.location
//            MuequetaSingleton.sharedInstance.asignarLatitud(currentLocation!.coordinate.latitude)
//            MuequetaSingleton.sharedInstance.asignarLongitud(currentLocation!.coordinate.longitude)
            MuequetaSingleton.sharedInstance.asignarLatitud(4.5971322)
            MuequetaSingleton.sharedInstance.asignarLongitud(-74.071869)
        }
        
        do {
            let url = NSURL(string: "http://192.168.0.24:8080/lugares")!
            let request = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "GET"
            
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request){ data,response,error in
                if error != nil{
                    print(error!.localizedDescription)
                    return
                }
                do {
                    if let responseJSON = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String:AnyObject] {
                        for lugar in (responseJSON["lugares"] as? NSArray)! {
                            let actual = lugar as? NSArray
                            let idL = (actual![0] as! Int)
                            let nom = (actual![1] as! String)
                            let desc = (actual![2] as! String)
                            let coorFinales = (0.0, 0.0)
                            let fot = [Foto]()
                            let vid = [String]()
                            
                            // MARK: Adds each place
                            
                            let rating = Rating(rating:0)
                            let lugar = Lugar(nombre: nom, descripcion: desc, id: idL,fotos: fot, videos: vid,coordenadas: coorFinales,rating: rating)
                            MuequetaSingleton.sharedInstance.agregarLugar(lugar)
                            
                            // MARK: Get images for each place
                            
                            do {
                                // create get request
                                let url2 = NSURL(string: "http://192.168.0.24:8080/lugares/" + String(idL) + "/imagenes")!
                                let request2 = NSMutableURLRequest(URL: url2)
                                request2.HTTPMethod = "GET"
                                
                                let task2 = NSURLSession.sharedSession().dataTaskWithRequest(request2){ data2,response2,error2 in
                                    if error2 != nil{
                                        print(error2!.localizedDescription)
                                        return
                                    }
                                    do {
                                        if let responseJSON2 = try NSJSONSerialization.JSONObjectWithData(data2!, options: []) as? [String:AnyObject] {
                                            for imagen in (responseJSON2["imagenes"] as? NSArray)! {
                                                let actual2 = imagen as? NSArray
                                                let direccion = (actual2![0] as! String)
                                                let descripcion = (actual2![1] as! String)
                                                let foto = Foto(name: direccion, group:nom,descripcion: descripcion)
                                                lugar.fotos.append(foto)
                                            }
                                        }
                                    } catch let error2 as NSError {
                                        print(error2.localizedDescription)
                                    }
                                }
                                task2.resume()
                            } catch let error2 as NSError {
                                print(error2.localizedDescription)
                            }
                            
                            // MARK: Get videos for each place
                            
                            do {
                                // create get request
                                let url3 = NSURL(string: "http://192.168.0.24:8080/lugares/" + String(idL) + "/videos")!
                                let request3 = NSMutableURLRequest(URL: url3)
                                request3.HTTPMethod = "GET"
                                
                                let task3 = NSURLSession.sharedSession().dataTaskWithRequest(request3){ data3,response3,error3 in
                                    if error3 != nil{
                                        print(error3!.localizedDescription)
                                        return
                                    }
                                    do {
                                        if let responseJSON3 = try NSJSONSerialization.JSONObjectWithData(data3!, options: []) as? [String:AnyObject] {
                                            for video in (responseJSON3["videos"] as? NSArray)! {
                                                let actual3 = video as? NSArray
                                                lugar.videos.append((actual3![0] as! String))
                                            }
                                        }
                                    } catch let error3 as NSError {
                                        print(error3.localizedDescription)
                                    }
                                }
                                task3.resume()
                            } catch let error3 as NSError {
                                print(error3.localizedDescription)
                            }
                        }
                    }
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
            task.resume()
        } catch let error as NSError {
            print(error.localizedDescription)
        }

    }
    
//     MARK: Will Appear
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.performSelector(#selector(self.darLugaresSeleccion(_:)), withObject: NSNumber(double: 4.0), afterDelay: 4.0)
    }
    
    func darLugaresSeleccion(executionTime: NSNumber) {
        MuequetaSingleton.sharedInstance.encontrarLugaresCerca(MuequetaSingleton.sharedInstance.darLatitud(), longitud:MuequetaSingleton.sharedInstance.darLongitud())
        print("Se recuperaron exitosamente los lugares de la base de datos")
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "encontrarLugaresCercanos" {
            MuequetaSingleton.sharedInstance.encontrarLugaresCerca(4.602968, longitud: -74.0672007)
        }
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
}