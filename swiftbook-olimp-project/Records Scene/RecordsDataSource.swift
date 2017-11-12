//
//  RecordsDataSource.swift
//  swiftbook-olimp-project
//
//  Created by Калугин on 11.11.17.
//  Copyright © 2017 Gleb Kalachev. All rights reserved.
//

import UIKit

extension RecordsViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return defaultRecords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordTableViewCell", for: indexPath) as! RecordTableViewCell
        
//        print("dataManager.records.sorted(by: > ): \(dataManager.records.sorted(by: > ))")
        
        let record = dataManager.records.sorted(by: > )[indexPath.row]
        
        print("record: \(record)")
        
        cell.numberOfRecordLabel.text = "\(indexPath.row + 1)"
        cell.nameLabel.text = "\(record.name)"
        cell.recordValueLabel.text = "\(record.value)"
        
        switch indexPath.row {
        case 0:
            cell.recordValueLabel.font = cell.recordValueLabel.font.withSize(25)
            cell.recordValueLabel.textColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
            cell.nameLabel.font = cell.nameLabel.font.withSize(23)
            cell.nameLabel.textColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        case 1:
            cell.recordValueLabel.font = cell.recordValueLabel.font.withSize(24)
            cell.recordValueLabel.textColor = #colorLiteral(red: 0.9583352208, green: 0.8847941756, blue: 0.2802580595, alpha: 1)
            cell.nameLabel.font = cell.nameLabel.font.withSize(22)
            cell.nameLabel.textColor = #colorLiteral(red: 0.9583352208, green: 0.8847941756, blue: 0.2802580595, alpha: 1)
        case 2:
            cell.recordValueLabel.font = cell.recordValueLabel.font.withSize(23)
            cell.recordValueLabel.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            cell.nameLabel.font = cell.nameLabel.font.withSize(21)
            cell.nameLabel.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        default:
            break
        }
        
        return cell
    }
    
}
