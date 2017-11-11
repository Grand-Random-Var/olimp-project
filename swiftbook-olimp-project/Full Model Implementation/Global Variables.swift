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



//Легко изменяемая, отчего удобная структура(а фактически enum) для содержания значений
struct FarmChange {
    static let low = 50 //Тестовое значение. Актуальное значение 50~60
    static let medium = 13 //Тестовое значение. Актуальное значение 30~40
    static let high = 9 //Тестовое значение. Актуальное значение 15~30
}
