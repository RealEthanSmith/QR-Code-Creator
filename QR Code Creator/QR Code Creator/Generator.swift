//
//  ViewController.swift
//  QR Code Creator
//
//  Created by Emmett Shaughnessy on 5/22/18.
//  Copyright © 2018 Emmett Shaughnessy. All rights reserved.
//

import UIKit
import MessageUI

class Generator: UIViewController, MFMailComposeViewControllerDelegate {
    
    //MARK: Connect
    @IBOutlet weak var dataField: UITextField!
    @IBOutlet weak var CodeSelector: UISegmentedControl!
    @IBOutlet weak var displayCodeView: UIImageView!
    var filter:CIFilter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //Hide keyboard when touch outside
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func convertTypes(cmage:CIImage) -> UIImage
    {
        let context:CIContext = CIContext.init(options: nil)
        let cgImage:CGImage = context.createCGImage(cmage, from: cmage.extent)!
        let image:UIImage = UIImage.init(cgImage: cgImage)
        return image
    }
    
    //MARK: Button
    @IBAction func generatePressed(_ sender: UIButton) {
        
        if var text = dataField.text {
            
            if text == "" {
                text = "This is an empty code"
            }
            
            let data = text.data(using: .ascii, allowLossyConversion: false)
            
            if CodeSelector.selectedSegmentIndex == 0 {
                filter = CIFilter(name: "CICode128BarcodeGenerator")
            }else{
                filter = CIFilter(name: "CIQRCodeGenerator")
            }
            
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 10, y: 10)
            let fixedImage = UIImage(ciImage: filter.outputImage!.transformed(by: transform))
            
            displayCodeView.image = fixedImage
            
            //Setup for Saving
            let saveImage = convertTypes(cmage: filter.outputImage!.transformed(by: transform))
            var imageData = UIImagePNGRepresentation(saveImage)
            //Saving...
            let compressedImage = UIImage(data: imageData!)
            UIImageWriteToSavedPhotosAlbum(compressedImage!, nil, nil, nil)
                
            
            
            //Alert for Saving
            let alert = UIAlertController(title: "Code Generated", message:"Code has been saved to photo library", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

