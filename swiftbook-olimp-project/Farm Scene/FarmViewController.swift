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
    
    
    //Это всё convenience properties
    private var swiftcoin: Int {get{ return dataManager.swiftcoins } set{ dataManager.swiftcoins = newValue }}
    private var energy: Int {get{ return dataManager.energy } set{ dataManager.energy = newValue }}
    private var clickCount: Int {get{ return dataManager.clickCount } set{ dataManager.clickCount = newValue }}
    
    var miner: Miner!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //времменная мера до осуществления сохранения последнего использованного miner'a (т.е. пока что по дефолту будет первый майнер)
        self.setMiner()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.setMiner), name: NSNotification.Name.init("minerChanged"), object: nil)
        
        //Убрал во viewWillAppear
        //self.setIndicators()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Переместил self.setIndicators() в viewWillAppear, чтобы label'ы своевременно обновлялись
        self.setIndicators()
    }
    
    @IBAction func farmButtonTapped(_ sender: UIButton) {
        
        if miner.performMining() {
            print("increased swiftcoin count")
            swiftcoin += 1
        }
        miner.enegryConsumeClosure()
        setIndicators()
    }
    
    //Установка и обновление label'ов индикаторов
    private func setIndicators() {
        swiftcoinsCountLabel.text = "свифткоины: \(swiftcoin)"
        energyCountLabel.text = "энергия: \(energy)"
    }
    
    @objc private func setMiner() {
        self.miner = dataManager.miners[dataManager.lastUsedMinerIndex]
        self.minerImageView.image = miner.image
    }
    
}



