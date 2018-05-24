//
//  ViewController.swift
//  QR Code Creator
//
//  Created by Emmett Shaughnessy on 5/22/18.
//  Copyright © 2018 Emmett Shaughnessy. All rights reserved.
//

import UIKit

class Generator: UIViewController {
    
    //MARK: Connect
    @IBOutlet weak var dataField: UITextField!
    @IBOutlet weak var CodeSelector: UISegmentedControl!
    @IBOutlet weak var displayCodeView: UIImageView!
    var filter:CIFilter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
            let image = UIImage(ciImage: filter.outputImage!.transformed(by: transform))
            
            displayCodeView.image = image
            
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

