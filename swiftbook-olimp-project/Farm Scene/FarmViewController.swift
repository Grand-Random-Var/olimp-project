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
    @IBOutlet weak var minerNameLabel: UILabel!
    
    
    @IBOutlet weak var farmButton: UIButton!
    
    
    //Это всё convenience properties
    private var swiftcoin: Int {get{ return dataManager.swiftcoins } set{ dataManager.swiftcoins = newValue }}
    private var energy: Int {get{ return dataManager.energy } set{ dataManager.energy = newValue }}
    private var clickCount: Int {get{ return dataManager.clickCount } set{ dataManager.clickCount = newValue }}
    
    var miner: Miner!
    
    //Свойство, показывающее, есть возможность фармить или нет
    var isAbleToFarm: Bool {
        
        //Если не первый(бесплатный) майнер...
        if miner! != dataManager.miners.first! {
            //...то проверяем наличие энергии
            return dataManager.energy > 0
        } else {
            //в случае если бесплатный, то, конечно, можно. Возвращаем true
            return true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //времменная мера до осуществления сохранения последнего использованного miner'a (т.е. пока что по дефолту будет первый майнер)
        self.setMinerProperties()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.setMinerProperties), name: NSNotification.Name.init("minerChanged"), object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Переместил self.updateIndicators() в viewWillAppear, чтобы label'ы своевременно обновлялись
        self.updateIndicators()
//        self.setFarmButtonEnabledIfEnegryAllows()
    }
    
    @IBAction func farmButtonTapped(_ sender: UIButton) {
        
        //Чтобы фармить, нужно проверить, позволяет ли тебе фармить количетво энергии...
        guard self.isAbleToFarm else {
            //...в противном случае появляется AlertController, сообщающий, что не хватает энергии
            let ac = UIAlertController.init(title: "Не хватает энергии!", message: "Пополните запасы энергии в магазине или используйте стандартный майнер", preferredStyle: .alert)
            
            ac.addAction(UIAlertAction.init(title: "Вернуться", style: .cancel, handler: nil))
            
            ac.addAction(UIAlertAction.init(title: "Использовать стандартный майнер", style: .default, handler: {(action) in 
                //Здесь нужно описать алгоритм переключения на стандартный майнер
                self.miner = dataManager.miners.first!
                dataManager.lastUsedMinerIndex = 0
                self.setMinerProperties()
            }))
            ac.addAction(UIAlertAction.init(title: "Купить 5 энергии за 2 свифткоина", style: .default, handler: { (action) in
                //Здесь нужно описать алгоритм покупки
                
                if dataManager.swiftcoins >= 2 {
                    dataManager.swiftcoins -= 2
                    dataManager.energy += 5
                    self.updateIndicators()
                } else {
                    let ac = UIAlertController.init(title: nil, message: "Слишком мало свифткоинов", preferredStyle: .alert)
                    ac.addAction(UIAlertAction.init(title: "Вернуться", style: .cancel, handler: { (action) in
                        //пока нет идей, что здесь можно и вообще нужно писать
                    }))
                    
                    self.present(ac, animated: true, completion: nil)
                }
            }))
            self.present(ac, animated: true, completion: nil)
            return
        }
        
        if miner.performMining() {
            print("increased swiftcoin count")
            swiftcoin += swiftcoinIncreasement
        }
        miner.enegryConsumeClosure()
        
        
        
        updateIndicators()
    }
    
    //Установка и обновление label'ов индикаторов
    private func updateIndicators() {
        swiftcoinsCountLabel.text = "свифткоины: \(swiftcoin)"
        energyCountLabel.text = "энергия: \(energy)"
    }
    
    //Функция, устанавливающая в соответствующие outlet'ы значения текущего miner'a
    @objc private func setMinerProperties() {
        self.miner = dataManager.miners[dataManager.lastUsedMinerIndex]
//        print("lastUsed index: \(dataManager.lastUsedMinerIndex)")
        self.minerImageView.image = miner.image
        self.minerNameLabel.text = miner.name
        
    }
    
    
    
    
}



