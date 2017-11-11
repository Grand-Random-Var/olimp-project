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
let dataManager = DataManager.shared


var swiftcoinIncreasement = 1 //Позже swiftcoinIncreasement станет вычисляемым свойством из-за плюшек в магазине


//Легко изменяемая, отчего удобная структура(а фактически enum) для содержания значений
struct FarmChange {
    static var low = 50 //Тестовое значение. Актуальное значение 50~60
    static var medium = 13 //Тестовое значение. Актуальное значение 30~40
    static var high = 9 //Тестовое значение. Актуальное значение 15~30
}
