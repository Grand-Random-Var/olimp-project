//
//  UserDataModel.swift
//  swiftbook-olimp-project
//
//  Created by Gleb Kalachev on 11/11/17.
//  Copyright © 2017 Gleb Kalachev. All rights reserved.
//

import Foundation
import UIKit



class Miner {
    
    
    
    //название, нужное для ячеек в MinersViewController 
    var name: String
    
    //
    var image: UIImage
    
    //upper_bound UInt32 значение шанса зафармить swiftcoin для функции arc4random_uniform(_)
    var farmChange: Int
    
    var enegryConsumeClosure: () -> Void
    
    //Полный инициализатор
    init(name: String, farmChance: Int, image: UIImage, enegryConsumeLogic: @escaping () -> Void) {
        
        self.name = name
        self.farmChange = farmChance
        self.image = image
        self.enegryConsumeClosure = enegryConsumeLogic
        
        
    }
    //Функция совершает рандом и возвращает true, если рандом попал. Если значения random и farmChange не совпадают, то 
    func performMining() -> Bool {
        
        //Создание рандомного числа
        let random = arc4random_uniform(UInt32(self.farmChange)) + 1
        print("random: \(random)")
        
        
        //В данном случае можно сравнивать random с каким угодно числом. Главное условие, чтобы для данного майнера это число было постоянным. В текущей имплементации такой константой будет свойство объекта farmChange
        if random == farmChange { return true }
        return false
    }
    
    
}



