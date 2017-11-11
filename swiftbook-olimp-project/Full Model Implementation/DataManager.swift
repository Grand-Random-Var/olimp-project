//
//  Core.swift
//  swiftbook-olimp-project
//
//  Created by Калугин on 11.11.17.
//  Copyright © 2017 Gleb Kalachev. All rights reserved.
//

import Foundation
import UIKit


//Ключи для извлечения информации из UserDefaults. Отсутствие такой структуры-енума - есть бэд практис
struct DataKeys {
    static let swiftcoins = "swiftcoins"
    static let energy = "energy"
    static let clickCount = "clickCount"
    static let lastUsedMinerIndex = "lastUsedMinerIndex"
    //    static let isBoughtArray = "isBoughtArray"
}

class DataManager {
    
    //Так как принял решение об одном глобальном dataManager'e, то shared нужен только для его инициализации
    static var shared = DataManager.init()
    
    
    //Решил, что лучше будет, если все майнеры будут храниться в DataManager'e, а не в MinersviewController'e. С этим решением связаны несколько проблем и крашей
    var miners : [Miner] = []
    //Здесь хранятся булева значения, показывающие, куплен майнер или нет. Всё под соответствующими индексами
    //    var isBoughtArray: [Bool] = []
    
    //Под рассмотрением
    //Тут под соответствующими индексами хранятся соответствующие цены
    //    var minersPriceArray: [Int] = [0, 50, 200]
    
    //Заменил название переменной "swiftCoins" на "swiftcoins", т.к. это одно слово. Например как пишется, к примеру, "Bitcoin"
    var swiftcoins: Int = 0  {didSet{ UserDefaults.standard.set(swiftcoins, forKey: DataKeys.swiftcoins) }}
    var energy: Int = 0 {didSet{ UserDefaults.standard.set(energy, forKey: DataKeys.energy) }}
    
    var clickCount: Int = 0 {didSet{ UserDefaults.standard.set(clickCount, forKey: DataKeys.clickCount) }}
    
    //Сохранение индекса последнего используемого майнера
    var lastUsedMinerIndex: Int = 0 {didSet {UserDefaults.standard.set(lastUsedMinerIndex, forKey: DataKeys.lastUsedMinerIndex)}}
    
    //уберу в глобал
//    let prices = [0, 50, 200]
    
    
    //бафы
    //    var chanceMultiplier
    
    private init() {
        
        //Убрал свойство defaults, чтобы память не ела и не путала
        //        let defaults = UserDefaults.standard
        
        //Извлечение или первая установка свойств
        self.swiftcoins = UserDefaults.standard.integer(forKey: DataKeys.swiftcoins)
        
        //        if let energy = UserDefaults.standard.value(forKey: "energy") as? Int {
        //            self.energy = energy
        //        }else{
        //            self.energy = 30
        //        }
        //перефразировал вышезакоменченный код в более сжатом формате
        self.energy = (UserDefaults.standard.value(forKey: DataKeys.energy) as? Int) ?? 30
        
        //Извлечение счетчика ходов у майнинг фермы
        self.clickCount = UserDefaults.standard.integer(forKey: DataKeys.clickCount)
        
        //Извлечение индекса последнего использованного майнера
        self.lastUsedMinerIndex = UserDefaults.standard.value(forKey: DataKeys.lastUsedMinerIndex) as? Int ?? 0
        
        
        //ВАЖНО: метод setMiners() должен исполняться после установки свойств 
        //        self.setMiners()
        self.setMiners()
        
        
    }
    
    
    //Просто решил инициализировать и устанавливать майнеров в массив в отдельном методе
    private func setMiners() {
        
        //Если под ключем isBoughtArray лежит nil, то устанавливаем начальное условие. Если не равен nil, то продолжаем 
        print("self.miners: \(self.miners)")
        print(UIImage.init(named: "видеокарта")!)
        
        //Добавление видеокарты
                miners.append(Miner.init(name: "видеокарта", pureFarmChance: FarmChance.low, price: prices[0], isBoughtDefault: true, image: UIImage.init(named: "видеокарта")!, enegryConsumeLogic: { 
                    //здесь делать ничего не нужно
                }))
        
        
        
        
        //Добавление домашней фермы
        
        miners.append(Miner.init(name: "Майнинг-Ферма", pureFarmChance: FarmChance.medium, price: prices[1], isBoughtDefault: false, image: UIImage.init(named: "майнинг-ферма")!, enegryConsumeLogic: { 
            
            //Шаги должны считаться только для средней машины, так что счет кликов в FarmViewController'e перемещается сюда
            //приходится писать не "+= 1", а "по-деревенски" из-за багов swift'a
            
            print("clickCount before: \(dataManager.clickCount)")
            
            dataManager.clickCount = dataManager.clickCount + 1
            
            //Шаг для потребления энергии сделаю меньше(т.е. чаще) чем farmChance данной машины
            
            
            //Если счетчик достиг предела, то уменьшаем энергию на 1 и сбрасываем счетчик
            if dataManager.clickCount >= clickCycleSize {
                dataManager.energy = dataManager.energy - 1
                dataManager.clickCount = 0
            }
            
            
            
            // Сделай в farmViewController'е проверку, является ли данный minder домашней фермой или нет. Если да, то прибавить 1 к счетчику кликов; в противном случае ничего не делать
            
        }))
        
        
        //Добавление майнинг завода
        
        
        miners.append(Miner.init(name: "Майнинг-Завод", pureFarmChance: FarmChance.high, price: prices[2], isBoughtDefault: false, image: UIImage.init(named: "майнинг-завод")!, enegryConsumeLogic: { 
            
            //Число, которое будем искать (можно обойтись вообще без этой переменной и сравнивать с нулем. Но пока что сделаю так :D )
            let expectedValue = 5
            
            let randomValue = Int(arc4random_uniform(UInt32(FarmChance.high * 1) /*1 может поменяться на что-то другое*/))
            
            //Прокнуло ли на снятие энергии?
            if expectedValue == randomValue {
                //Почему-то Swift 4.0.2 иногда воспринимает Int! как Int?. Поэтому строчку dataManager.energy -= 1 заменяю на эту:
                dataManager.energy = dataManager.energy - 1
            }
            
        }))
        
    }
    
//    private func alternativeSetMiners() {
//        print(miners)
//        dataManager.miners.append(Miner.init(name: "test1"))
//        dataManager.miners.append(Miner.init(name: "test2"))
//        dataManager.miners.append(Miner.init(name: "test3"))
//    }
}
