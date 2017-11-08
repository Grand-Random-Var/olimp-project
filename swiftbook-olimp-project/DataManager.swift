//
//  DataManager.swift
//  swiftbook-olimp-project
//
//  Created by Gleb Kalachev on 11/8/17.
//  Copyright © 2017 Gleb Kalachev. All rights reserved.
//

import Foundation

protocol DataManagerProtocol {
   func getData() -> [String];
   func resetData(withArray array: [String]);
}
