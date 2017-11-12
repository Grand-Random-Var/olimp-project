//
//  SettingsViewController.swift
//  swiftbook-olimp-project
//
//  Created by Gleb Kalachev on 11/11/17.
//  Copyright © 2017 Gleb Kalachev. All rights reserved.
//

import Foundation
import UIKit



class SettingsViewController: UIViewController {
    
    
    @IBOutlet weak var numberOfBlinksLabel: UILabel!
    @IBOutlet weak var numberOfBlinksSlider: UISlider!
    
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var speedSlider: UISlider!
    @IBOutlet weak var scorePerWinLabel: UILabel!
    
    let constSpeedValues = [1.2, 1, 0.8, 0.7, 0.6, 0.5, 0.4, 0.3, 0.2, 0.1]
    
    override func viewWillAppear(_ animated: Bool) {
        self.numberOfBlinksLabel.text = "\(Int(round((Double(dataManager.settings.numberOfBlinks) - 3)/7)))"
        self.numberOfBlinksSlider.value = round(Float(self.numberOfBlinksLabel.text!)!)
        
        mark: for (index,value) in constSpeedValues.enumerated() {
            if dataManager.settings.blinkDuration == value {
                self.speedLabel.text = "\(index + 1)"
                break mark
            }
        }
        self.speedSlider.value = (round(Float(self.speedLabel.text!)!))
        
    }
    
    @IBAction func numberOfBlinksSliderValueChanged(_ sender: UISlider) {
        
        var rounded = Int(sender.value * 7) + 3
        
        if rounded == 11 { rounded = 10 }
        
        self.numberOfBlinksLabel.text = "\(rounded)"
        
        try! realm.write {
            dataManager.settings.numberOfBlinks = rounded
        }
        
        scorePerWinLabel.text = "\(scorePerWin(withSettings: dataManager.settings))"
        
    }
    
    @IBAction func speedSliderValueChanged(_ sender: UISlider) {
        
        var rounded = Int(sender.value * 10) + 1
        
        if rounded >= 11 { rounded = 10 }
        
        
        
        self.speedLabel.text = "\(rounded)"
        
        try! realm.write {
            dataManager.settings.blinkDuration = constSpeedValues[rounded - 1]
        }
        
        scorePerWinLabel.text = "\(scorePerWin(withSettings: dataManager.settings))"
        
    }
    
    
    
}
