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
    static let records = "records"
    static let numberOfBlinks = "numberOfBlinks"
    static let blinkDuration = "blinkDuration"
    static let settings = "settings"
}

struct Record {
    let value: Int
    let name: String
}



struct Settings {
    var numberOfBlinks: Int
    var blinkDuration: TimeInterval
    
    init(withNumberOfBlinks numberOfBlinks: Int, blinkDuration: TimeInterval) {
        self.numberOfBlinks = numberOfBlinks
        self.blinkDuration = blinkDuration
    }
    
//    init(fromDict dict: Dictionary<String,Any>) {
//        self.numberOfBlinks = dict[DataKeys.numberOfBlinks]! as! Int
//        self.blinkDuration = dict[DataKeys.blinkDuration]! as! TimeInterval
//        
//    }
    
//    func setNumberOfBlinks(value: Int) {
//        UserDefaults.standard.set([DataKeys.blinkDuration: self.blinkDuration, DataKeys.numberOfBlinks: value], forKey: DataKeys.settings)
//        
//    }
//    func setBlinkDuration(value: Int) {
//        UserDefaults.standard.set([DataKeys.blinkDuration: value, DataKeys.numberOfBlinks: self.numberOfBlinks], forKey: DataKeys.settings)
//    }
    
//    static func getSettings() -> Settings {
//        let fetchedSettings = Settings.init(fromDict: UserDefaults.standard.value(forKey: DataKeys.settings)! as! Dictionary<String,Any>) 
//        return fetchedSettings
//    }
//    static func save(settings: Settings) {
//        var dict = Dictionary<String, Any>()
//        dict[DataKeys.numberOfBlinks] = self.numberOfBlinks
//        dict[DataKeys.blinkDuration] = self.blinkDuration
//        UserDefaults.standard.set(dict, forKey: DataKeys.settings)
//    }
}

class DataManager {
    
    
    
    //Так как принял решение об одном глобальном dataManager'e, то shared нужен только для его инициализации
    
    var records: [Record] {
        return UserDefaults.standard.value(forKey: DataKeys.records)! as! [Record]
    }
    
    //Будет пока загружаться дефолт во viewDidLoad
    var settings: Settings!
    
    static var shared = DataManager.init()
    
    private let maxRecordsCount = 10
    
    private init() {
        
        //Установка стандарных настроек
//        print("asdf ", defaultSettings.numberOfBlinks)
        self.settings = Settings.init(withNumberOfBlinks: 6, blinkDuration: 0.2)
        
        if UserDefaults.standard.value(forKey: DataKeys.records) as? [Record] == nil {
            UserDefaults.standard.set(Array<Record>(), forKey: DataKeys.records)
        }    
        
    }
    
    //Функция, автоматически вставляющая рекорд на надлежащее место
    func setRecord(_ recordValue: Int) {
        
        let newRecord = Record(value: recordValue, name: "test")
        var records = self.records
        records.append(newRecord)
        
        records = records.sorted { (current, next) -> Bool in
            return current.value > next.value
        }
        
        for _ in 0 ... records.count - maxRecordsCount - 1 {
            records.remove(at: records.count - 1)
        }
        
        UserDefaults.standard.set(records, forKey: DataKeys.records)
        
    }
    
    //Функция определяет, является ли набранный счет рекордным
    func isRecord(_ value: Int) -> Bool {
        
        
        
        
        return true
    }
    
}
