//
//  ViewController.swift
//  swiftbook-olimp-project
//
//  Created by Gleb Kalachev on 11/7/17.
//  Copyright © 2017 Gleb Kalachev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    @IBAction func action(sender: UIButton) {
        label.text = textField.text
    }
    
}

