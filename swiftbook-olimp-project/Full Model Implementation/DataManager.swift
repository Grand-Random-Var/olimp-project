//
//  Core.swift
//  swiftbook-olimp-project
//
//  Created by Калугин on 11.11.17.
//  Copyright © 2017 Gleb Kalachev. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift


//Ключи для извлечения информации из UserDefaults. Отсутствие такой структуры-енума - есть бэд практис

struct DataKeys {
    static let records = "records"
    static let numberOfBlinks = "numberOfBlinks"
    static let blinkDuration = "blinkDuration"
    static let settings = "settings"
}

class Record: Object, Comparable {
    
    
    @objc dynamic var value: Int = 0
    @objc dynamic var name: String = ""
    
    convenience init(value: Int, name: String) {
        self.init()
        
        self.value = value 
        self.name = name
        
    }
    
    static func <(lhs: Record, rhs: Record) -> Bool {
        return lhs.value < rhs.value
    }
    
    static func ==(lhs: Record, rhs: Record) -> Bool {
        return lhs.value == lhs.value
    }
}


class Settings: Object {
    
    @objc dynamic var numberOfBlinks: Int = 0
    @objc dynamic var blinkDuration: TimeInterval = 0.0
    
    convenience init(withNumberOfBlinks numberOfBlinks: Int, blinkDuration: TimeInterval) {
        self.init()
        self.numberOfBlinks = numberOfBlinks
        self.blinkDuration = blinkDuration
    }
    
}

class DataManager {
    
    
    
    //Так как принял решение об одном глобальном dataManager'e, то shared нужен только для его инициализации
    
    var records: Results<Record>!
    
    //Будет пока загружаться дефолт во viewDidLoad
    var settings: Settings!
    
    static var shared = DataManager.init()
    
    private let maxRecordsCount = 10
    
    private init() {
        
        
        if realm.objects(Settings.self).count != 0 {
            self.settings = realm.objects(Settings.self).first!
        } else {
            try! realm.write {
                realm.add(defaultSettings)
            }
            self.settings = realm.objects(Settings.self).first!
        }
        
        if realm.objects(Record.self).count == 0 {
            try! realm.write {
                realm.add(defaultRecords)
            }
            self.records = realm.objects(Record.self)
        } else {
            self.records = realm.objects(Record.self)
        }
        
        
    }
    
    //Функция, автоматически вставляющая рекорд на надлежащее место
     
    
}

extension Int {
    func isRecord() -> Bool {
        let recordsArray = dataManager.records.sorted(by: < )
        for record in recordsArray {
            if self > record.value {
                return true
            }
        }
        return false
    }
    
    func putToRecordsIfItIs() -> Bool {
        
        let recordsArray = dataManager.records.sorted(by: < )
        
        for record in recordsArray {
            if self > record.value {
                try! realm.write {
                    realm.delete(record)
                    let newRecord = Record.init(value: self, name: "Вы")
                    realm.add(newRecord)
                }
            }
        }
        
        return true
    }
}
