//
//  File.swift
//  Muequeta
//
//  Created by Meili Vanegas Hernández on 10/29/16.
//  Copyright © 2016 Meili Vanegas Hernández. All rights reserved.
//

import UIKit
import AVFoundation
import CoreLocation

class Prueba: UITableViewController {
    
    // MARK: Will Appear
    
    override func viewDidLoad() {
        var vid = [String]()
        do {
            // create get request
            let url3 = NSURL(string: "http://192.168.0.24:8080/lugares/" + String("hola") + "/videos")!
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
                            print((actual3![0] as! String))
                            vid.append((actual3![0] as! String))
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

        
        super.viewDidLoad()
    }
    
}