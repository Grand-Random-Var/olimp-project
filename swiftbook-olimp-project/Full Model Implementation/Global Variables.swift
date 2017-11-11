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

var swiftcoinIncreasement = 1 //Позже swiftcoinIncreasement станет вычисляемым свойством из-за плюшек в магазине



//Цены на miner'ы . Пока что этот массив находится здесь. Его нужно будет куда-нибудь перенести
let prices = [0, 50, 200]

//Вычисляемся переменная, означающая, раз в сколько кликов будет сниматься единица энергии (вычисляемая, потому впоследствии в вычисление добавятся бафы)
var clickCycleSize: Int {
    return 1
}

//Double рандом ви диапазоне 0..<1 (хотя ноль, по-моему, тоже не входит в диапазон)
func randomFrom0To1() -> Double {
    return Double(arc4random())/Double(UInt32.max)
}

let dimAlphaConstant: CGFloat = 0.5
