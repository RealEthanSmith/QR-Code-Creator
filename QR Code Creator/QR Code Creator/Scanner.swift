//
//  Scanner.swift
//  QR Code Creator
//
//  Created by Emmett Shaughnessy on 5/22/18.
//  Copyright © 2018 Emmett Shaughnessy. All rights reserved.
//

import UIKit
import AVFoundation

class Scanner: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet weak var crosshair: UIImageView!
    @IBOutlet weak var scan: UIButton!
    @IBOutlet weak var stopScan: UIButton!
    var video = AVCaptureVideoPreviewLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scan.backgroundColor = UIColor.red
        stopScan.backgroundColor = UIColor.white
        
        //Creating session
        let session = AVCaptureSession()
        
        //Define capture devcie
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        
        do
        {
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            session.addInput(input)
        }
        catch
        {
            print ("ERROR")
        }
        
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr, AVMetadataObject.ObjectType.code128]
        
        video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = view.layer.bounds
        view.layer.addSublayer(video)
        
        self.view.bringSubview(toFront: crosshair)
        self.view.bringSubview(toFront: scan)
        self.view.bringSubview(toFront: stopScan)
        
        session.startRunning()
        
    }
    
    var scanningForCode = 0
    
    @IBAction func userscans(_ sender: UIButton) {
        scanningForCode = 1
        stopScan.backgroundColor = UIColor.red
    }
    
    @IBAction func userstops(_ sender: UIButton) {
        scanningForCode = 0
        stopScan.backgroundColor = UIColor.white
    }
    
    
    
    //AVMetadataObject.ObjectType.qr
        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            if metadataObjects != nil && metadataObjects.count != 0 && scanningForCode == 1{
                if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject {
                    
                    
                    
                    if object.type == AVMetadataObject.ObjectType.qr {
                        let alert = UIAlertController(title: "Your code is:", message: object.stringValue, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Retake", style: .default, handler: nil))
                        alert.addAction(UIAlertAction(title: "Copy", style: .default, handler: { (nil) in
                            UIPasteboard.general.string = object.stringValue
                        }))
                        present(alert, animated: true, completion: nil)
                    }
                    
                    
                    
                    if object.type == AVMetadataObject.ObjectType.code128{
                        let alert = UIAlertController(title: "Your code is:", message: object.stringValue, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Retake", style: .default, handler: nil))
                        alert.addAction(UIAlertAction(title: "Copy", style: .default, handler: { (nil) in
                            UIPasteboard.general.string = object.stringValue
                        }))
                        present(alert, animated: true, completion: nil)
                    }
                    
                    
                    
                }
            }
        }

   
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
