//
//  UserDataModel.swift
//  swiftbook-olimp-project
//
//  Created by Gleb Kalachev on 11/11/17.
//  Copyright © 2017 Gleb Kalachev. All rights reserved.
//

import Foundation
import UIKit



class Miner: Equatable {
    
    //название, нужное для ячеек в MinersViewController 
    var name: String
    var image: UIImage
    //upper_bound UInt32 значение шанса зафармить swiftcoin для функции arc4random_uniform(_) (переделано)
    //Теперь farmChance выражается в Double, что развяжет нам руки в создании бафов
    var pureFarmChance: Double
    var price: Int
    
    private var isBoughtCustomDataKey: String {
        return self.name + "IsBought"
    }
    var isBought: Bool! {
        get {
            return UserDefaults.standard.value(forKey: self.isBoughtCustomDataKey)! as! Bool
        }
        set {
            UserDefaults.standard.set(newValue, forKey: self.isBoughtCustomDataKey)
        }
    }

    
    
    
    
    var enegryConsumeClosure: () -> Void
    
    //Полный инициализатор
    init(name: String, pureFarmChance: Double, price: Int, isBoughtDefault: Bool = false, image: UIImage, enegryConsumeLogic: @escaping () -> Void) {
        
        
        self.name = name
        self.pureFarmChance = pureFarmChance
        self.image = image
        self.enegryConsumeClosure = enegryConsumeLogic
        self.price = price
        
        //Если нет сохранений isBought, то берем входной параметр isBoughtDefault. (т.е. если сохранения есть, то isBoughtDefault будет не использован)
        self.isBought = UserDefaults.standard.value(forKey: self.isBoughtCustomDataKey) as? Bool ?? isBoughtDefault
        //Такую вещь как isBought после инициализации нужно сохранить под уникальным ключом
        UserDefaults.standard.set(self.isBought, forKey: self.isBoughtCustomDataKey)
        
    }
    //Функция совершает рандом и возвращает true, если рандом попал. Если значения random и farmChange не совпадают, то 
    func performMining() -> Bool {
        
        
        
        //Механизм вычисления рандома: если рандомное число попало в диапазон от 0 до farmChance, то true
        if pureFarmChance >= randomFrom0To1() { return true }
        return false
    }
    
    
    init(name: String) {
        self.name = name 
        self.pureFarmChance = 0.5
        self.image = UIImage.init(named: "видеокарта")!
        self.enegryConsumeClosure = {}
        self.price = 228
        self.isBought = true
    }
    //Чтобы сравнивать ( нужно для метода setFarmButtonEnabledIfEnegryAllows() )
    static func ==(lhs: Miner, rhs: Miner) -> Bool {
        return lhs.name == rhs.name
    }
    static func !=(lhs: Miner, rhs: Miner) -> Bool {
        return lhs.name != rhs.name
    }
    
}



