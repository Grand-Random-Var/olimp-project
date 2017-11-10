//
//  ViewController.swift
//  swiftbook-olimp-project
//
//  Created by Gleb Kalachev on 11/7/17.
//  Copyright © 2017 Gleb Kalachev. All rights reserved.
//

import UIKit

class MinersViewController: UIViewController {
    
    //Outlet'ы
    @IBOutlet weak var swiftcoinsCountLabel: UILabel!
    @IBOutlet weak var energyCountLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    //Properties
    var miners: [Miner] = []
    
    
    override func viewDidLoad() {
        
        //Добавление видеокарты
        miners.append(Miner.init(name: "Видеокарта", farmChance: 20 /*test value*/, image: UIImage.init(named: "видеокарта")!, enegryConsumeLogic: { 
            //здесь делать ничего не нужно
        }))
        
        
        //Добавление домашней фермы
        
        //Шанс зафармить для домашней фермы
        let middleFarmChance = 13
        miners.append(Miner.init(name: "Майнинг-Ферма", farmChance: middleFarmChance /*test value*/, image: UIImage.init(named: "майнинг-ферма")!, enegryConsumeLogic: { 
            
            //Шаг для потребления энергии сделаю меньше(т.е. чаще) чем farmChance данной машины
            let clickCycleSize = middleFarmChance - 4
            
            let currentClick = UserDataManager.shared.clickCount
            
            //Если счетчик достиг предела, то уменьшаем энергию на 1 и сбрасываем счетчик
            if currentClick >= clickCycleSize {
                UserDataManager.shared.energy -= 1
                UserDataManager.shared.clickCount = 0
            }
            
            // Сделай в farmViewController'е проверку, является ли данный minder домашней фермой или нет. Если да, то прибвлять 1 к счетчику кликов; в противном случае ничего не делать
            
        }))
        
        
        //Добавление майнинг завода
        
        //Шанс зафармить для майнинг завода
        let highFarmChance = 9
        miners.append(Miner.init(name: "Майнинг-Завод", farmChance: highFarmChance, image: UIImage.init(named: "майнинг-завод")!, enegryConsumeLogic: { 
            
            //Число, которое будем искать (можно обойтись вообще без этой переменной и сравнивать с нулем. Но пока что сделаю так :D )
            let expectedValue = 5
            
            let randomValue = Int(arc4random_uniform(UInt32(highFarmChance * 1) /*1 может поменяться на что-то другое*/))
            
            //Прокнуло ли на снятие энергии?
            if expectedValue == randomValue {
                UserDataManager.shared.energy -= 1
            }
            
        }))
        
        
        
    }
    
}
