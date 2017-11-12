//
//  RecordsDataSource.swift
//  swiftbook-olimp-project
//
//  Created by Калугин on 11.11.17.
//  Copyright © 2017 Gleb Kalachev. All rights reserved.
//

import UIKit

extension RecordsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordTableViewCell", for: indexPath) as! RecordTableViewCell
        print("хуй: \(dataManager.records.count)")
        
        let record = dataManager.records[indexPath.row]
        
        cell.numberOfRecordLabel.text = "\(indexPath.row + 1)"
        cell.nameLabel.text = "\(record.name)"
        cell.nameLabel.text = "\(record.value)"
        
        
        return cell
    }
    
}
