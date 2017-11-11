//
//  Global Variables.swift
//  swiftbook-olimp-project
//
//  Created by Gleb Kalachev on 11/11/17.
//  Copyright © 2017 Gleb Kalachev. All rights reserved.
//

import Foundation
import UIKit

//Вместо того, чтобы постоянно теребить DataManager.shared, гоу попробуем глобальный dataManager
var dataManager = DataManager.shared


//Double рандом ви диапазоне 0..<1 (хотя ноль, по-моему, тоже не входит в диапазон)
//func randomFrom0To1() -> Double {
//    return Double(arc4random())/Double(UInt32.max)
//}

let defaultSettings = Settings.init(withNumberOfBlinks: 4, blinkDuration: 0.4)


let delayBeforePlayingCombination = 1.6
let dimAlphaConstant: CGFloat = 0.5
let blinkAnimationDurationOnTap : TimeInterval = 0.2
let rightTileTappedColor = #colorLiteral(red: 0.6649962664, green: 0.9938375354, blue: 0.6506955624, alpha: 1)
let wrongTileTappedColor = #colorLiteral(red: 0.9142631888, green: 0.4493378405, blue: 0.416197886, alpha: 1)
let defaultTileColor = #colorLiteral(red: 0.8484306931, green: 0.8455678821, blue: 0.8485279679, alpha: 1)

//Функция, подсчитывающая по уровню сложности очки зарабатываемые за выигрыш в раунде
func scorePerWin(withSettings inputSettings: Settings) -> Int {
    
//    let inputSettings = Settings.init(withNumberOfBlinks: numberOfBlinks, blinkDuration: blinkDuration)
    
    
    var floatScore: Double = Double(inputSettings.numberOfBlinks * 10)
    
//    var multiplier: Double = 0
    
    //Если быстрее...
    if inputSettings.blinkDuration <= defaultSettings.blinkDuration {
        // то увиличиваем сильнее
        
        let multiplierIncreaser = 1.3
        
//        print("default: \()")
//        print("this: \(round(    (floatScore * (1.0 + (defaultSettings.blinkDuration - inputSettings.blinkDuration) * multiplierIncreaser) * (1.0 + (defaultSettings.blinkDuration - inputSettings.blinkDuration) * multiplierIncreaser))    ))")
        
        floatScore = round(    (floatScore * (1.0 + (defaultSettings.blinkDuration - inputSettings.blinkDuration) * multiplierIncreaser) * (1.0 + (defaultSettings.blinkDuration - inputSettings.blinkDuration) * multiplierIncreaser))    )
        
    } else {
        
        let multiplierIncreaser = 0.5
        
        floatScore = round(    (floatScore * (1.0 + (defaultSettings.blinkDuration - inputSettings.blinkDuration) * multiplierIncreaser) * (1.0 + (defaultSettings.blinkDuration - inputSettings.blinkDuration) * multiplierIncreaser))    )
        
    }
    
    
    return Int(floatScore)
    
}
