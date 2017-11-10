//
//  FarmViewController.swift
//  swiftbook-olimp-project
//
//  Created by Gleb Kalachev on 11/10/17.
//  Copyright © 2017 Gleb Kalachev. All rights reserved.
//

import UIKit

class FarmViewController: UIViewController {
    
    @IBOutlet weak var swiftcoinsCountLabel: UILabel!
    
    @IBOutlet weak var energyCountLabel: UILabel!
    
    @IBOutlet weak var minerImageView: UIImageView!
    
    @IBOutlet weak var farmButton: UIButton!
    
    let userDataManager = UserDataManager.shared
    var swiftCoin: Int {get{ return userDataManager.swiftCoins } set{ userDataManager.swiftCoins = newValue }}
    var energy: Int {get{ return userDataManager.energy } set{ userDataManager.energy = newValue }}
    var clickCount: Int {get{ return userDataManager.clickCount } set{ userDataManager.clickCount = newValue }}
    
    var miner: Miner!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setIndicators()
        
        
    }
    
    @IBAction func farmButtonTapped(_ sender: UIButton) {
        
        if miner.performMining() {
            swiftCoin += 1
        }
        miner.enegryConsumeClosure()
        setIndicators()
    }
    
    func setIndicators() {
        swiftcoinsCountLabel.text = "swiftcoins: \(swiftCoin)"
        energyCountLabel.text = "energy: \(energy)"
    }
    
}
