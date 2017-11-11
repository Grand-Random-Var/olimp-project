//
//  ShopViewController.swift
//  swiftbook-olimp-project
//
//  Created by Gleb Kalachev on 11/10/17.
//  Copyright © 2017 Gleb Kalachev. All rights reserved.
//

import UIKit

class ShopViewController: UIViewController {
    
    @IBOutlet weak var swiftcoinsCountLabel: UILabel!
    @IBOutlet weak var energyCountLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        self.updateIndicators()
    }
    
    
    //Установка и обновление label'ов индикаторов
    private func updateIndicators() {
        swiftcoinsCountLabel.text = "свифткоины: \(dataManager.swiftcoins)"
        energyCountLabel.text = "энергия: \(dataManager.energy)"
    }
}
