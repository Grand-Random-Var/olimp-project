//
//  Core.swift
//  swiftbook-olimp-project
//
//  Created by Калугин on 11.11.17.
//  Copyright © 2017 Gleb Kalachev. All rights reserved.
//

import Foundation

class UserDataManager {
    
    static let shared = UserDataManager()
    private let defaults = UserDefaults.standard
    
    private init() {
        let defaults = UserDefaults.standard
        
        swiftCoins = defaults.integer(forKey: "swiftCoins")
        if let energy = defaults.value(forKey: "energy") as? Int {
            self.energy = energy
        }else{
            self.energy = 30
        }
        clickCount = defaults.integer(forKey: "clickCount")
    }
    
    var swiftCoins = 0  {didSet{ defaults.set(swiftCoins, forKey: "swiftCoins") }}
    var energy = 0 {didSet{ defaults.set(energy, forKey: "energy") }}
    var clickCount = 0 {didSet{ defaults.set(clickCount, forKey: "clickCount") }}
    
}
