//
//  ScannerViewController.swift
//  Muequeta
//
//  Created by Meili Vanegas Hernández on 9/14/16.
//  Copyright © 2016 Meili Vanegas Hernández. All rights reserved.
//

import AVFoundation
import UIKit

class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    // MARK: Properties
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var lugares = [Lugar]()
    
    // MARK: Did load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lugares = MuequetaSingleton.sharedInstance.lugares
        
        view.backgroundColor = UIColor.blackColor()
        captureSession = AVCaptureSession()
        
        let videoCaptureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed();
            return;
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
            metadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        } else {
            failed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession);
        previewLayer.frame = view.layer.bounds;
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        view.layer.addSublayer(previewLayer);
        
        captureSession.startRunning();
    }
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .Alert)
        ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(ac, animated: true, completion: nil)
        captureSession = nil
    }
    
    // MARK: Will Appear
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession?.running == false) {
            captureSession.startRunning();
        }
    }
    
    // MARK: Will Disappear
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

        if (captureSession?.running == true) {
            captureSession.stopRunning();
        }
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            let readableObject = metadataObject as! AVMetadataMachineReadableCodeObject;
            
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            foundCode(readableObject.stringValue);
        }
        dismissViewControllerAnimated(true, completion: nil)
        performSegueWithIdentifier("detalleLugar", sender: self)
    }
    
    func foundCode(code: String) {
        let hour = NSCalendar.currentCalendar().component(.Hour, fromDate: NSDate())
        let min = NSCalendar.currentCalendar().component(.Minute, fromDate: NSDate())
        var data = code.componentsSeparatedByString(",")
        let lugar = MuequetaSingleton.sharedInstance.buscarLugar(data[0])
        MuequetaSingleton.sharedInstance.seleccionarLugar(lugar)
        MuequetaSingleton.sharedInstance.seleccionarHechos(Int(String(hour) + String(min))!)
        for hecho in MuequetaSingleton.sharedInstance.darHechosSeleccionados() {
            print (hecho.nombre)
        }
    }
    
    // MARK: Prepare for segue
    
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        if segue!.identifier == "detalleLugar" {
            let lugarDetail = UIStoryboard(name: "Main", bundle:nil).instantiateViewControllerWithIdentifier("LugarDetail") as UIViewController
            let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
            appDelegate.window?.rootViewController = lugarDetail
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .Portrait
    }
}