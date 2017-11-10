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
   init(name: String, farmChange: Int, image: UIImage, enegryConsumeLogic: @escaping () -> Void) {
      
      self.name = name
      self.farmChange = farmChange
      self.image = image
      self.enegryConsumeClosure = enegryConsumeLogic
      
      
   }
   
    func performMining() -> Bool {
        let random = arc4random_uniform(10) + 1
        if random < farmChange { return true }
        return false
    }
   
   
}



